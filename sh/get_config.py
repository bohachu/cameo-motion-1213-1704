from pathlib import Path
# import yaml
import configparser

def read_config():

    path_config = Path(__file__).resolve(
    ).parents[0].joinpath('.user-env')

    # try:
    with open(path_config, 'r', encoding='utf-8') as f:
        cfg = f.read()
        config = yaml.load(cfg, Loader=yaml.CLoader)
    return config

    # except Exception as e:
    #     logging.info(
    #         f'''
    #         read_config failed.
    #         {e}
    #         ''',
    #         exc_info=True
    #     )


CONFIG_GLOBAL = read_config()