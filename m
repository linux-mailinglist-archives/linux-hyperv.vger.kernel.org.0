Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFFA31A2DA
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Feb 2021 17:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhBLQiP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Feb 2021 11:38:15 -0500
Received: from mail-mw2nam10on2115.outbound.protection.outlook.com ([40.107.94.115]:50017
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230527AbhBLQgL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Feb 2021 11:36:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGV9EbfPL3HHFUAobifEyMgVLiFU5uJVmsu+6STIHA9O3Cy8wN/Gy3ADa3qcGvsEgd7yUBSg4jJocZ1PrDabZa/1yLrV4p6iJtl6xRys6zN4rcCXoAfKUvXwCdP+CKxtRinTKFSyUkpsaUkv38xs/13YUvO8LAtJi/6Z4mG9B8dxcKc2x0f4L7n94bjrHvClEOqSVxdoSbt/HMFiETchmNaM/kcIjwZlGFKJGPcp4GKRzoeqPpqOEQqmJADflDhBQHq/P418Nlx3BMu/LaOvDbUVlxbxXpkQMg741VbHBl/XYOwwfQzRFvVJSWMKQNIkCypX5JVGyoRdrMFKPiMZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP2mnFvJgJ7vp0tFrKCgz+PArvdiiKV9++4s2DuegQ8=;
 b=NBiwrhM4W5HLw1zlSvLBazl9gD0A25IbOxQQkeiHOl5xXF1vg6uFpNwPFe/lFGJKz+3R2s2HkWXzrZIexmqmw4/KciPvSsyeYRIkRBQ95Y770RwAacWU+2apb026IU+KuRjG8qY3B+m8M4BxL1e9/QEatNSfPSOLsYXafmKoGR2hmKgZu8D5Ik9Oc2C/eiBcCm08tDnTD2sYiGln5qNKZiSYEKD3/7SmYzd34S52yNpninVfpg/HQx34bm3CBKPxYkG6G7iPOk8/x698vqhb+D44yg05w83laoy5BuLdUIH70MQBLGYSc1zv7PzR8GOSZxoviMrmcOj0bJGrIanjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP2mnFvJgJ7vp0tFrKCgz+PArvdiiKV9++4s2DuegQ8=;
 b=eRQF6PHj18v59k8ivF6sq3rLArGtzpUAJ4n9u3U9ZOfsccSe+9MaEFufR/QRbSGFzvKgpycgI0T1AarIVuWWcgdN4d8azfpVbZtj9PZg8jblQ5PtbBnkrVUVr3cE0mD3dD/Wu0KiV4j73TA6qOphjL88dIFKm2Ql7Fy9OK0d+bc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR2101MB0874.namprd21.prod.outlook.com (2603:10b6:301:7e::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.7; Fri, 12 Feb
 2021 16:35:16 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Fri, 12 Feb 2021
 16:35:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     melanieplageman <melanieplageman@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "andres@anarazel.de" <andres@anarazel.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        melanieplageman <melanieplageman@gmail.com>
Subject: RE: [PATCH v3] scsi: storvsc: Parameterize number hardware queues
Thread-Topic: [PATCH v3] scsi: storvsc: Parameterize number hardware queues
Thread-Index: AQHXAMx7G8GrUlQ5zUOjW2P1qe9C2qpUsILw
Date:   Fri, 12 Feb 2021 16:35:16 +0000
Message-ID: <MWHPR21MB15932F068976333B8D3DCEFCD78B9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210211231803.25463-1-melanieplageman@gmail.com>
In-Reply-To: <20210211231803.25463-1-melanieplageman@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-12T16:35:14Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1ba80333-8103-4ebd-83a0-1b8310bdaff8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f84d5ff-aeb6-40a0-71fc-08d8cf742db0
x-ms-traffictypediagnostic: MWHPR2101MB0874:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR2101MB0874455458AF2C27200400CBD78B9@MWHPR2101MB0874.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPHnZxQrzDGYo0wEW5gt5WpXm2Ca4EwR2KAMCMuWZXWAzoGfi16yh8cHY3Ep9OUgoiKuZDi6Br8/693PvRBT/I5wqUx1pVa79BUmmG/95jZomsy/sm1z0YIDeXMmMbD6H82WFGxwKt2Gz3HW1ZHWjxeSxYrV/5mT6S7A4+sDL3XWIKnZKeiHn4HX1DpB3N9tfLEx20mjcmzOt79gyNJeE6yPv8jIBlgY5tT1KjFyOq5aowrhPxoV3zHN3mlWyizd+saNQEb9E5UsidFfl5IBCO9PiskbtEuX0NJVqtDPcmdwv3cijOl8E4wN/K04vsJGr7ikF8aqFxBFjTOCrF4jJtwD9+uxl+5XdZY+k11uRu8I15JTMfb4t2IIQ9/JN/pMu5/8Y8BVo9/HZqaT82wtf9poB6CME9F6zdHZ5Lw0EXDMXu2HG6REZMFJexlZwWMftoYFz/d8YSN0z2kHyfl9DeT1x9rs+KL4ApSJUdZ0cbKx9bXDRksUxJvBRTqUXNXyBCbmMPHAesoNbSyA2AhiuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(6506007)(82960400001)(33656002)(66946007)(76116006)(478600001)(2906002)(8990500004)(8676002)(82950400001)(66476007)(7696005)(26005)(55016002)(316002)(10290500003)(186003)(52536014)(66556008)(66446008)(64756008)(54906003)(5660300002)(110136005)(9686003)(71200400001)(83380400001)(4326008)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WTOQwOvhp6uK6nspG2tK+uRHAoLhtcr6WIM1yEERnLaTcDizA1mWiZhKK4mU?=
 =?us-ascii?Q?MycWlIsJ9r4Ltzn1r+vWW/YC51IDGllc1M+kvRG1998sXrLgkEjejrT5+NFu?=
 =?us-ascii?Q?zKyUjgzOVraGv+mD+uudReYEpVl0sDlEuFFCW2WP8GTR6WjdSSLiqQQp3uc7?=
 =?us-ascii?Q?gIjZiPc57HxPIAvxBDux5SQl7HUZPj1VaD6WK+y/EF3P58qQfY7KW50W+Kxk?=
 =?us-ascii?Q?FqmY0Kd6vHE4oUelR93nmV2A19hM5BH/hHddad/dyS3fMabFJMRgy9b7c87s?=
 =?us-ascii?Q?hPMx05wFboxLGdrkgVrcj+R18sp7zZlAwUXFZ7+qmxifOZL8YtDnWJF4eVAg?=
 =?us-ascii?Q?MHh/eg68CQAFSKbb2G3E5gImrYzxqjlp8jKfK9hGz6mKwX6hB0kn7xxsnSst?=
 =?us-ascii?Q?u+HVxIIhwUSwHglvtJpPgBk58cYBrSyGvL4HWfyNWqLobsveO44Hs8sFNCl0?=
 =?us-ascii?Q?EI+jyNEstp2navdOTCjuivgrzeZrY6ZLTCBh3c5HOyjzgKrkb+efw6dWxqPb?=
 =?us-ascii?Q?IeOK9Jqd/gfOZGpbl5dK+ZEbL2rGM/1LYQ+5NoAKWrXoj2NzMiMiW9sb50xl?=
 =?us-ascii?Q?vAB1O9J5IIJ9Gk9Mvh4eYzWE6q1W18YUP6u93FeG73SvCHiV2g8mi9m0iHyq?=
 =?us-ascii?Q?NQzJiwzThoD3SNnwAWoD1kI/oCwAgAZ+B/R9H8uFJaLVw66xRwCQl/uaJWCp?=
 =?us-ascii?Q?1Nx/GZA4Vfgj6Bq9iGNHOza5vXHpDhtRGu88UuqU7Zd84GcgH09E6YUk36V+?=
 =?us-ascii?Q?W7IP4Q4kiixGXuVRDi5PimPw2v10m/FAvwovw/OEF+S5pvgnmS8SD1/r/UCh?=
 =?us-ascii?Q?v6b1xxzMCqPuqvW0S7bOa/MhKO0hBxMZAcaIrIf5AHtkAXrImy1hTVFqG+Ze?=
 =?us-ascii?Q?NYgMmfNyfPKOxRv21CiXp1BtdmbSRtl9QV0xUFCaoSOQusYF4BjJb7V9mDB0?=
 =?us-ascii?Q?1mLaQqyI+NCMYCajTxclizyuM3Y6NjmrU7AcEnyREHSlzH7gL9uz2bggYdmj?=
 =?us-ascii?Q?IoKTetLdqtWDhRpK/hq7Y15AtzzHARnM5iwi78rqt10KE4JLoitGNxAaktMZ?=
 =?us-ascii?Q?/9XGRh2Xu6kxo8VEZWadTGFn2Dr3KqjidN9Onp1eGbBUGaZr5EZB5Sc7blI9?=
 =?us-ascii?Q?re2H1M9WBzaa8sv4kJN6kAUeGnzM/lDM8jS8uHFfPhsaHAOygpJVlw+C0giZ?=
 =?us-ascii?Q?zIGjQi87030uEpBnjnGAm21FcLhljmY/AoGubut+tAFJF7iwaVM9TFi8Mhyk?=
 =?us-ascii?Q?3aXGC/4E+54Of6Byv1KWIe9ZBDRsUutAqLCRbziBm0eTndW2UXNtuVSFFGeM?=
 =?us-ascii?Q?5PEIzeSmkdXaVqETFaM/ZZYv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f84d5ff-aeb6-40a0-71fc-08d8cf742db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 16:35:16.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40O6WpnPg0JPeqqWPZg+s9Mlsu5IWceMYFAUstDQiUUjIM41sJc5kNGcQ+1z61F3IAsbPhA8ONroZqN7xl51phY/FbF+OBUyipm+SABweaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0874
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Melanie Plageman <melanieplageman@gmail.com> Sent: Thursday, February=
 11, 2021 3:18 PM
>=20
> Add ability to set the number of hardware queues with new module paramete=
r,
> storvsc_max_hw_queues. The default value remains the number of CPUs.  Thi=
s
> functionality is useful in some environments (e.g. Microsoft Azure) where
> decreasing the number of hardware queues has been shown to improve
> performance.
>=20
> Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
> ---
>  drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 2e4fa77445fd..a64e6664c915 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
>  static int storvsc_change_queue_depth(struct scsi_device *sdev, int queu=
e_depth);
>=20
>  static int storvsc_vcpus_per_sub_channel =3D 4;
> +static int storvsc_max_hw_queues =3D -1;
>=20
>  module_param(storvsc_ringbuffer_size, int, S_IRUGO);
>  MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
>=20
> +module_param(storvsc_max_hw_queues, int, S_IRUGO|S_IWUSR);
> +MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware
> queues");
> +

There's been an effort underway to not use the symbolic permissions in
module_param(), but to just use the octal digits (like 0600 for root only
access).   But I couldn't immediately find documentation on why this
change is being made.  And clearly it hasn't been applied to the
existing module_param() uses here in storvsc_drv.c.  But with this being
a new parameter, let's use the recommended octal digit format.

>  module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
>  MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to
> subchannels");
>=20
> @@ -1897,6 +1901,7 @@ static int storvsc_probe(struct hv_device *device,
>  {
>  	int ret;
>  	int num_cpus =3D num_online_cpus();
> +	int num_present_cpus =3D num_present_cpus();
>  	struct Scsi_Host *host;
>  	struct hv_host_device *host_dev;
>  	bool dev_is_ide =3D ((dev_id->driver_data =3D=3D IDE_GUID) ? true : fal=
se);
> @@ -2004,8 +2009,19 @@ static int storvsc_probe(struct hv_device *device,
>  	 * For non-IDE disks, the host supports multiple channels.
>  	 * Set the number of HW queues we are supporting.
>  	 */
> -	if (!dev_is_ide)
> -		host->nr_hw_queues =3D num_present_cpus();
> +	if (!dev_is_ide) {
> +		if (storvsc_max_hw_queues =3D=3D -1)
> +			host->nr_hw_queues =3D num_present_cpus;
> +		else if (storvsc_max_hw_queues > num_present_cpus ||
> +			 storvsc_max_hw_queues =3D=3D 0 ||
> +			storvsc_max_hw_queues < -1) {
> +			storvsc_log(device, STORVSC_LOGGING_WARN,
> +				"Resetting invalid storvsc_max_hw_queues value to default.\n");
> +			host->nr_hw_queues =3D num_present_cpus;
> +			storvsc_max_hw_queues =3D -1;
> +		} else
> +			host->nr_hw_queues =3D storvsc_max_hw_queues;
> +	}

I have a couple of thoughts about the above logic.  As the code is written,
valid values are integers from 1 to the number of CPUs, and -1.  The logic
would be simpler if the module parameter was an unsigned int instead of
a signed int, and zero was the marker for "use number of CPUs".  Then
you wouldn't have to check for negative values or have special handling
for -1.

Second, I think you can avoid intertwining the logic for checking for an
invalid value, and actually setting host->nr_hw_queues.  Check for an
invalid value first, then do the setting of host->hr_hw_queues.

Putting both thoughts together, you could get code like this:

	if (!dev_is ide) {
		if (storvsc_max_hw_queues > num_present_cpus) {
			storvsc_max_hw_queues =3D 0;
			storvsc_log(device, STORVSC_LOGGING_WARN,
				"Resetting invalid storvsc_max_hw_queues value to default.\n");
		}
		if (storvsc_max_hw_queues)
			host->nr_hw_queues =3D storvsc_max_hw_queues
		else
			host->hr_hw_queues =3D num_present_cpus;
	}

>=20
>  	/*
>  	 * Set the error handler work queue.
> @@ -2169,6 +2185,14 @@ static int __init storvsc_drv_init(void)
>  		vmscsi_size_delta,
>  		sizeof(u64)));
>=20
> +	if (storvsc_max_hw_queues > num_present_cpus() ||
> +		storvsc_max_hw_queues =3D=3D 0 ||
> +		storvsc_max_hw_queues < -1) {
> +		pr_warn("Setting storvsc_max_hw_queues to -1. %d is invalid.\n",
> +			storvsc_max_hw_queues);
> +		storvsc_max_hw_queues =3D -1;
> +	}
> +

Is this check really needed?  Any usage of the value will be in
storvsc_probe() where the same check is performed.  I'm not seeing
a scenario where this check adds value over what's already being
done in storvsc_probe(), but maybe I'm missing it.

>  #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
>  	fc_transport_template =3D fc_attach_transport(&fc_transport_functions);
>  	if (!fc_transport_template)
> --
> 2.20.1

