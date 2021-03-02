Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88B32B75F
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Mar 2021 12:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhCCLBq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 06:01:46 -0500
Received: from mail-dm6nam12on2139.outbound.protection.outlook.com ([40.107.243.139]:34784
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1448309AbhCBRaa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 12:30:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6jy6BRWnSBZxo99rYcEa3xw0Cgx/YbY6M6zQ3hdLfLuNlRbPzUUHd36hYWRuSSWzaBV4c7sAr0ufc98Hal4+WXUNsI+Xhn+r/t6Dt1xFDiM645r9/RM9A7o20ovQaNu0k9r5keLnDnNl7Zsu8WmzvFQzPtgenFJyo+zqCDyJeYl3d2+WH2qVNEAaBLnmYehK65yATKO8J0ABJzVeNlV6hBNWlC4wkdQjb4iqhZszAH7fTtwTVXRkXEAjcIEtAZfwAioLjv7ZKSMxB+rdCWdze+2T143LNB5TCl8RVaVhrAuP6rPl41iamoEY6Z31OnisrMemvaWAAZYluFIngQR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsP5fpkUj5ki8tdoWB7pjBOjp5BNUdIqRngjoQEnaYM=;
 b=iBlreo1ftZlD5M5O3b4iK1JCJLErVggVg1ItCHaSjNGZUWZvJvErjzGqId8zVkWwqkJOGH8WGf1LuQc1+o+FEYppDSiDdcMglShL/vXS0IhmRInM2zZObh7Sd5EyA3+9mzSVR0+yVTtSCnDzD6qEdElxR3DvGg9dJKpoyLYZKd14IK0u85CfOLcdZ1l7UzFaa94OZgN30VsGKP4eSvP+sexrl6LEIxXaXJJAdQY3pvz1OLlRRoEnqJC52no6rqqxOZAIJAWNv3CeD+1Nc97V3Z+LskUoVP7KvzieIvQxkQoX7eucboC0wOdJ1woQGc1QPAr+lT8dvJe7uKXHoy/72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsP5fpkUj5ki8tdoWB7pjBOjp5BNUdIqRngjoQEnaYM=;
 b=WSCtUAhbsDUzVIIPejeqiJWeaqKF0Uhvq8HwtMukzUNiwokc1Yo8hULmWjNaIht4hA0GXi1nAzGiiZVvPNBAw2aKnfM8wcG2FbIkEAaZX2+NKnzLqAW+KKlF+cdNGVx/qSwA6gXdIagPhCU/vprF5G2ueXSghceKvwnJlVkfraI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0288.namprd21.prod.outlook.com (2603:10b6:300:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.9; Tue, 2 Mar
 2021 17:28:21 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 17:28:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     melanieplageman <melanieplageman@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        melanieplageman <melanieplageman@gmail.com>
Subject: RE: [PATCH v4] scsi: storvsc: Parameterize number hardware queues
Thread-Topic: [PATCH v4] scsi: storvsc: Parameterize number hardware queues
Thread-Index: AQHXCwUQHXrHFh28K0+I9x7ikbetNapw/EHQ
Date:   Tue, 2 Mar 2021 17:28:21 +0000
Message-ID: <MWHPR21MB1593F81E368757DEAD2960F6D7999@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210224232948.4651-1-melanieplageman@gmail.com>
In-Reply-To: <20210224232948.4651-1-melanieplageman@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-02T17:28:19Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=475095d5-d179-4a4f-a28f-7a0751b152ff;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4c227a3-843f-4a87-f92e-08d8dda09391
x-ms-traffictypediagnostic: MWHPR21MB0288:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0288FCA4EB003B002E8ACDE0D7999@MWHPR21MB0288.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fvMt+94suAYW4w3p+LKMkQfvR3w7TRJ6Z3v2hBa5uvxDyxSMNGzA9Ra6nqTB4aAr0OtggLNyakej+sR+lFHPb4YoQs2UTS++EAekCuGDfeY5V2PFtV3y6jkY5hVu4RT63pGriu9BUwehMFd2QBhMBsq15TlfwVCEmjrPCiQ4+2NYecy9iTCfe2nLgUWlRhi1Ks3+yJcFRJ/8mTr266fBx33Uuxj3uKyWmv1pdLvirE54Q3XN9Egwhh9peOtmXXNdYkf6zLbKR8o+N0skgMoywFORTu984Pe7rrC/L7+xcixgV6kihDf7fwFrwOnooL5rljry4+Bw0ZMVfIuik70Od6pUIx54zXomig+j4s4zBtLMTEOi8EuBvE/qT/z93yuoWsGXwAVutLzngkR9CdCjM0X+szrMbaRPw2vXIXRghHFTN35I02G0o6qXB4b26VmFk6WzXgstOSHpIBf89iYqy/EontfAs1sDMd0hT/HIroF2xDFCiw8lOY+m5CMel118yIBHLFzuKchNLp3Y4kEvnSlAVWlAUvscuOkRD7mqdzNPEerOOv2AfJl6u48OR6P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(76116006)(2906002)(33656002)(82960400001)(82950400001)(52536014)(55016002)(54906003)(66556008)(66446008)(478600001)(64756008)(8936002)(8990500004)(83380400001)(66476007)(9686003)(66946007)(71200400001)(186003)(10290500003)(26005)(4326008)(110136005)(8676002)(5660300002)(86362001)(6506007)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zXFFi5by+X+019dGbppho08bw1cazAMnVaRuSSYNRkfOnO4ANksuXlOEMg/B?=
 =?us-ascii?Q?t30V/HqYQuxJGb2AeoHlqwHTFN+zXWd5NCI9MPTqrLhLU+t8TP3bWKCdIDGc?=
 =?us-ascii?Q?huqzhl/g8QtDd7OtD+G095uc2qe9N3S2Hsa8pVMUQqrZDqNQx+XLOMkQfY/J?=
 =?us-ascii?Q?VeIEsmf/x2QrS+IllfNW77YyJ3lGiF+5pUQdsZL3bBRSNv7yClfM08OAsxen?=
 =?us-ascii?Q?9NHqyYFQqvAPo7iEJZKfjK3MDkOo11hyRpzuXmH6VAopcUrKpbbO/w2fwDJ8?=
 =?us-ascii?Q?HJIb7gWCiV+7KJ3DtRfzh8149291vzE/f/PvzUcL1fN5BD+EuAhy+/a4GIny?=
 =?us-ascii?Q?XnCOMSiJp4Ye0p1UAcMyorwG3mp2PFZD5dMMhIEbyV2ohQbz3GKxfTWkXe5V?=
 =?us-ascii?Q?lJnct4u6b9jM92hGBOP6x6oDln701dNsLcoRWqvk0cfDfAluM2gMz8sNxmpk?=
 =?us-ascii?Q?zC3r5JhqwygF4GEot7OC8ommje8ZsrWspqkUhQ0kqsanS9tFqTYoh4JDLrHK?=
 =?us-ascii?Q?UzBLhOYVkcGt3t/71Nqj8Yfc46Kb9JWDlJdd4wOyop5hmvzgo/2kM02KhBj1?=
 =?us-ascii?Q?+b8la3fl536JTF6gkZ9egp+E9kVjQO73QgDeuZeB6qGUYKYc/UqtdUsH8dKB?=
 =?us-ascii?Q?aXgcuOVNjhEBSVVZVZSlhZOInA5pBCgo9/gXRQbkNuh0/aWq2LbSRTj1Ikix?=
 =?us-ascii?Q?1zu7Faui55TEFKNxOrVKLK4eHY06bop76zTHvaB0hO1YkgnZ3NvhujnBtX90?=
 =?us-ascii?Q?AuPySyoPO3hewWi1djf38V1RF3FEUSeYoj53Q1/9pRpba1qKduDXzQ6Xy0Us?=
 =?us-ascii?Q?mLUxT+lHab0RQnOGrQxUkBxbcos1DNC2dCYCb/y6DNV2b6pv/rgX3/OqElR8?=
 =?us-ascii?Q?AciH6tk+lqLsBqtiukKH8sh9tUXYPVJxS4lsRxvDy5Wbi4cm+J38mEYEawsH?=
 =?us-ascii?Q?P+Ao8pks5JlWQ1y+kRVtnMwIHh/9dL9H7mopQ/NwcPwN9saF3UOLvfs3SXmJ?=
 =?us-ascii?Q?xSq1kLfVrbmhwO6lqKUA02iA64m+ndX9VSYLJ85kxsjJ6BRRenwjrYrxY4+Z?=
 =?us-ascii?Q?7ZLaZ9e+V/JJQ03sBu8u0kwhMLACMKqVJ0MVMDah4H7Omz5kBDWSGA8Bye0D?=
 =?us-ascii?Q?xLb0bd0eWpXE/S8EV2+k9NylVRZu+/QAYLcrjo94uXd1diNyaPQ75TEn9kSm?=
 =?us-ascii?Q?lU71GvY3yO9YtiDHRNDRh4tBVSepUwYd6VKDIAKQG2cnkQFauGXB00zOaITq?=
 =?us-ascii?Q?DjqCkH47sVIKmAlwTf3LXdskt61QkBB+2LHAQjrZ5OVwFDp0zfM7ZSXynBib?=
 =?us-ascii?Q?BdI6STmf2LYMGXOKITWqKaVx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c227a3-843f-4a87-f92e-08d8dda09391
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 17:28:21.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iga1Y+HTEfDYxjJ6vBVXlh+eDggBrfv7R6nu3x0ybZ0Ypa4RSSABXilSqpKg3LjU6TAovtFr217XXJRjqGEVpxu6KIqgQ6+o17tSsjhIcjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0288
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Melanie Plageman (Microsoft) <melanieplageman@gmail.com> Sent: Wednes=
day, February 24, 2021 3:30 PM
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
> Updated since v3:
> - permissions in octal
> - param type changed to unsigned int
> - removed value checking from module init function
> - simplified value checking logic in probe function
>=20
>  drivers/scsi/storvsc_drv.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 6bc5453cea8a..dfe005c03734 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -366,10 +366,14 @@ static u32 max_outstanding_req_per_channel;
>  static int storvsc_change_queue_depth(struct scsi_device *sdev, int queu=
e_depth);
>=20
>  static int storvsc_vcpus_per_sub_channel =3D 4;
> +static unsigned int storvsc_max_hw_queues;
>=20
>  module_param(storvsc_ringbuffer_size, int, S_IRUGO);
>  MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
>=20
> +module_param(storvsc_max_hw_queues, uint, 0644);
> +MODULE_PARM_DESC(storvsc_max_hw_queues, "Maximum number of hardware queu=
es");
> +
>  module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
>  MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to
> subchannels");
>=20
> @@ -1907,6 +1911,7 @@ static int storvsc_probe(struct hv_device *device,
>  {
>  	int ret;
>  	int num_cpus =3D num_online_cpus();
> +	int num_present_cpus =3D num_present_cpus();
>  	struct Scsi_Host *host;
>  	struct hv_host_device *host_dev;
>  	bool dev_is_ide =3D ((dev_id->driver_data =3D=3D IDE_GUID) ? true : fal=
se);
> @@ -2015,8 +2020,17 @@ static int storvsc_probe(struct hv_device *device,
>  	 * For non-IDE disks, the host supports multiple channels.
>  	 * Set the number of HW queues we are supporting.
>  	 */
> -	if (!dev_is_ide)
> -		host->nr_hw_queues =3D num_present_cpus();
> +	if (!dev_is_ide) {
> +		if (storvsc_max_hw_queues > num_present_cpus) {
> +			storvsc_max_hw_queues =3D 0;
> +			storvsc_log(device, STORVSC_LOGGING_WARN,
> +				"Resetting invalid storvsc_max_hw_queues value to default.\n");
> +		}
> +		if (storvsc_max_hw_queues)
> +			host->nr_hw_queues =3D storvsc_max_hw_queues;
> +		else
> +			host->nr_hw_queues =3D num_present_cpus;
> +	}
>=20
>  	/*
>  	 * Set the error handler work queue.
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
