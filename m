Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD7987A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfHUXKj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 19:10:39 -0400
Received: from mail-eopbgr820107.outbound.protection.outlook.com ([40.107.82.107]:32727
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbfHUXKj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 19:10:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEklszr955VXeKwAwEdO1lhUFnFbHhx9N/WPFlmgSChvWWA+upisLX0k/HzOpfkq6gLnEW2oKpisQeuS3twjo8o8qaILzvxRdzFNkFvj65RqYLqJnLk4gclfPaagPO+0NpFaQEZttLwqBlDPD9dSS4Fu8WG3mgg+ysS0Dmg6FLz3wOKigItZyDhnxExwhfdcbHWmY0Tn6GpMUX1rqPg3ksAUMUHOTXEztcTb8X1S9h1idB+mYNIUYbyo5PAm+3O/AGR+AsSLb/6dV0mjyiREadGi3bt0N7AJvwUpB0Co5pbxkXlt35JRl4YbzGmh9sn+/P1muO1xzLjYOJ5ZZd6VUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkHEL6qMgaFNtNeta/c8i/yh+pP+vs5P63jinOg9/iA=;
 b=a0v0n4coYGZSSZazvarWRiy0uX/hrP2xVACygDnC1nGxaiDYi20S2AIF/gYOlxUO4F9m3eHZQ9ZjxNzbGNXWgBANc6OrEbS+fP1esNcmW7ZDXC5ZSMUUTKlOW6ADQScHxhwnMXWh5j7zzv/cfEJgT5K72KYnyPtv5DassQacL9PeDveo3Zy6iA4DqR8uklXaJpieSFILz1XL/CnOu7/44j2jahPrFaTEXRP8fxKgVANyFmYr3hZhSxH6ggyfGmI0uepdCIPrJe5ZneaEddxrcNT6WiBD7hlrWmkwB5VoSMHC7FFUjg3fpqdJD3W7Pl/KFT6suFhHDYUPi/zVUStR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkHEL6qMgaFNtNeta/c8i/yh+pP+vs5P63jinOg9/iA=;
 b=DWhR43+ce82eIhWIfjDI9A1Su3/UlZ3Z9wsy4BPdAFLy4JyMOksncOwTfwCgFAhbh35okVOdvF1DN4cph+qzTGoC1SkxOs3Muo38/z47M3yhrhMJiXWOrcnMlfbiPFXOHjJI1sMkuvmbRvP8eV2+YXkHhJ768JdBw8IxLQgv+kE=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0699.namprd21.prod.outlook.com (10.175.112.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.2; Wed, 21 Aug 2019 23:10:33 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Wed, 21 Aug 2019
 23:10:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] drivers: hv: vmbus: add test attributes to debugfs
Thread-Topic: [PATCH v3 2/3] drivers: hv: vmbus: add test attributes to
 debugfs
Thread-Index: AQHVV7CExu5bjRhcDUSpSbsyf+SIMacGNsGw
Date:   Wed, 21 Aug 2019 23:10:32 +0000
Message-ID: <DM5PR21MB0137B4071E64688C5F902E83D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <cover.1566340843.git.brandonbonaby94@gmail.com>
 <a17474c59601a98576f1e002a57192f6314b4aaf.1566340843.git.brandonbonaby94@gmail.com>
In-Reply-To: <a17474c59601a98576f1e002a57192f6314b4aaf.1566340843.git.brandonbonaby94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-21T23:10:31.0905286Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=51bb54f1-506c-4815-8aff-330654b52c72;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4975f03d-6126-47b6-126b-08d7268cc495
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0699;
x-ms-traffictypediagnostic: DM5PR21MB0699:|DM5PR21MB0699:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB069995B58CABAF6ABB391727D7AA0@DM5PR21MB0699.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(189003)(74316002)(76116006)(3846002)(25786009)(7736002)(14444005)(55016002)(2906002)(66066001)(52536014)(4326008)(9686003)(1511001)(66476007)(22452003)(110136005)(2501003)(229853002)(316002)(8990500004)(54906003)(53936002)(6436002)(26005)(11346002)(10090500001)(99286004)(8676002)(71200400001)(14454004)(76176011)(478600001)(476003)(6246003)(66446008)(10290500003)(102836004)(64756008)(66556008)(33656002)(81156014)(186003)(256004)(81166006)(305945005)(86362001)(7696005)(71190400001)(6116002)(446003)(486006)(6506007)(66946007)(8936002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0699;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7s/Ggjg3f1HvGRxNWtfS2nuLHr7H+l8ABAnGXYQBibESex5L3GVVW6ioZ8fpXPUD6I6fzz4w3pUsPP9OjSIv0HcILhPa44Zy/EceF6U+2hEohKH3ue4pNlbZ1SxcIYyGaOYR003/q8sBAzRPZzQ8hPhq2wSmE9LwbqybEm+82iIzjJN85xuPMdvLG1E113Bf/chCjBfVp3mQY1d9DKHeqKN83LJph1e0G3/QoJBoRlYSyFVVvDX4cN2iNhjYyENN83myRV3HK2YV6cDq8/RpctXF79SqvM4UzjhBVcnYQSyrWRq+lpMexfQCX8WRiR+vEYANE6IE6PTTjjynA9XXFaf3wtfEr61hwZfG2FfhRe1DkxEwBlGESpvz3AQwxy0oxy7EZ4mfmcyGCP2AvqY8ffbay9YY+mqz9eg08EIC+zQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4975f03d-6126-47b6-126b-08d7268cc495
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 23:10:32.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTwfuIidH3/9e3AO+GEl/PFb7ilJbXIkLmN9odEd6I2F+IIe7jiMWS674lt5tdenvja8qDbD1AcknNUvixA2UD5SvKSz5zVUJ4zCk8fXetg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0699
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Tuesday, August 20, =
2019 4:39 PM
>=20
> Expose the test parameters as part of the debugfs channel attributes.
> We will control the testing state via these attributes.
>=20
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
> Changes in v3:
>  - Change call to IS_ERR_OR_NULL, to IS_ERR.
>=20
> Changes in v2:
>  - Move test attributes to debugfs.
>  - Wrap test code under #ifdef statements.
>  - Add new documentation file under Documentation/ABI/testing.
>  - Make commit message reflect the change from from sysfs to debugfs.
>=20
>  Documentation/ABI/testing/debugfs-hyperv |  21 +++
>  MAINTAINERS                              |   1 +
>  drivers/hv/vmbus_drv.c                   | 167 +++++++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hyperv
>=20
> diff --git a/Documentation/ABI/testing/debugfs-hyperv
> b/Documentation/ABI/testing/debugfs-hyperv
> new file mode 100644
> index 000000000000..b25f751fafa8
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-hyperv
> @@ -0,0 +1,21 @@
> +What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
> +Date:           August 2019
> +KernelVersion:  5.3
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing status of a vmbus device, whether its in an=
 ON
> +                state or a OFF state

Document what values are actually returned? =20

> +Users:          Debugging tools
> +
> +What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_buffer_i=
nterrupt_delay
> +Date:           August 2019
> +KernelVersion:  5.3
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing buffer delay value between 0 - 1000

It would be helpful to document the units -- I think this is 0 to 1000
microseconds.

> +Users:          Debugging tools
> +
> +What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_message_=
delay
> +Date:           August 2019
> +KernelVersion:  5.3
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing message delay value between 0 - 1000

Same here.

> +Users:          Debugging tools
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e81e60bd7c26..120284a8185f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7460,6 +7460,7 @@ F:	include/uapi/linux/hyperv.h
>  F:	include/asm-generic/mshyperv.h
>  F:	tools/hv/
>  F:	Documentation/ABI/stable/sysfs-bus-vmbus
> +F:	Documentation/ABI/testing/debugfs-hyperv
>=20
>  HYPERBUS SUPPORT
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index ebd35fc35290..d2e47f04d172 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -919,6 +919,10 @@ static void vmbus_device_release(struct device *devi=
ce)
>  	struct hv_device *hv_dev =3D device_to_hv_device(device);
>  	struct vmbus_channel *channel =3D hv_dev->channel;
>=20
> +#ifdef CONFIG_HYPERV_TESTING
> +	hv_debug_rm_dev_dir(hv_dev);
> +#endif /* CONFIG_HYPERV_TESTING */

Same comment in as previous patch about #ifdef inline in the code,
and similarly for other occurrences in this patch.

> +
>  	mutex_lock(&vmbus_connection.channel_mutex);
>  	hv_process_channel_removal(channel);
>  	mutex_unlock(&vmbus_connection.channel_mutex);
> @@ -1727,6 +1731,9 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  		pr_err("Unable to register primary channeln");
>  		goto err_kset_unregister;
>  	}
> +#ifdef CONFIG_HYPERV_TESTING
> +	hv_debug_add_dev_dir(child_device_obj);
> +#endif /* CONFIG_HYPERV_TESTING */
>=20
>  	return 0;
>=20
> @@ -2086,6 +2093,159 @@ static void hv_crash_handler(struct pt_regs *regs=
)
>  	hyperv_cleanup();
>  };
>=20
> +#ifdef CONFIG_HYPERV_TESTING
> +
> +struct dentry *hv_root;
> +
> +static int hv_debugfs_delay_get(void *data, u64 *val)
> +{
> +	*val =3D *(u32 *)data;
> +	return 0;
> +}
> +
> +static int hv_debugfs_delay_set(void *data, u64 val)
> +{
> +	if (val >=3D 1 && val <=3D 1000)
> +		*(u32 *)data =3D val;
> +	/*Best to not use else statement here since we want
> +	 * the delay to remain the same if val > 1000
> +	 */

The standard multi-line comment style would be:

	/*
	 * Best to not use else statement here since we want
	 * the delay to remain the same if val > 1000
	 */

> +	else if (val <=3D 0)
> +		*(u32 *)data =3D 0;

You could consider returning an error for an invalid
value (< 0, or > 1000).

> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(hv_debugfs_delay_fops, hv_debugfs_delay_get,
> +			 hv_debugfs_delay_set, "%llu\n");
> +

Michael
