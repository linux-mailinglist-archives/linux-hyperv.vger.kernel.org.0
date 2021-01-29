Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6230827F
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Jan 2021 01:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhA2AiI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jan 2021 19:38:08 -0500
Received: from mail-dm6nam10on2106.outbound.protection.outlook.com ([40.107.93.106]:5025
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231345AbhA2AhK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jan 2021 19:37:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD/zH+bv7M5yep/GegS5oXfKynjZ/7juwtYLvw9srNNmKZM9bA3hFWkl8UBcsDTYwUIu9TWWy5T+fkjLo37AO8aylI1gVC7rkWVAAeLV4MU8MtJLK0wTcLvTS4XOo9FwL2lZoNO0qyy86EOtBwTC409RRRvpeJejXb8Mn/WRmoxz5vjCrGBBz2/lpYPvt4eHnhkRBJ2gpc2Gk3+wh/x1EwDFOJF+Y2zy8TBVpl+lHJaaWJ0ZHc/1j5WXdvDIrPBEPLppaF2AQRK3nnZ5LHMeTm9wUEf9jNKMmmdEGpfWgvA88WwZqMHxxKSbVfHwyNWIyswqMFZyzaFUVMqdrCtXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S5UzqMvIVGksb83VXxI1mEeQAtdpzLFxpm4f5LlKhI=;
 b=BPJz1jod0SJxHfqVmRgr2F4SVNZCyUY/gp5ceWfHRAgII5LgfBBTpDb5CSWJLQ6Mmxl0lgvGYWig5hk2R7kifcbT9fJ07I/jA43aC48TpqWFvmk8UZh6ZRBfqVX6godSCblnBOLf0OS0/qcLPPlufh/QZdR2kvl1YAEdmArLUFkcRaL30D1X9TsVR0pL8yQCVaw3WTQl1uqgx07PSnF+Y2d4KDa8RWEvvN+gNlNLcMZhQUgyRi8UGG4Ayiugb/V7VWzUoQ3S5ALKrajiRRCSC71PzuUmlOaInMelUDAjxfXtbNYMs611+ebLZAgklnED781DikM6sP+MW6nNEWdR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S5UzqMvIVGksb83VXxI1mEeQAtdpzLFxpm4f5LlKhI=;
 b=JwFUQg7FzDkMIyUZrQ43iPkoVBBBMofwrvN/2oXfDMBNiGJ+aWiFJhAh0R1zOPZxMcuhaw9wpugw/TsHMeThWhLbnOMqiKKXId2vXH8mgo534q/KMqadCe35AxSI8Um2sRdq5jkXsCWh7yCoRNL/z9fYNcHIwVPbKTLoNzgd16U=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Fri, 29 Jan
 2021 00:35:49 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Fri, 29 Jan 2021
 00:35:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v2 2/4] Drivers: hv: vmbus: Restrict vmbus_devices on
 isolated guests
Thread-Topic: [PATCH v2 2/4] Drivers: hv: vmbus: Restrict vmbus_devices on
 isolated guests
Thread-Index: AQHW89pjBYSkqyTsO0iYKQ2fJDeahao9uKZA
Date:   Fri, 29 Jan 2021 00:35:49 +0000
Message-ID: <MWHPR21MB15930403D21DB84A717C2331D7B99@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210126115641.2527-1-parri.andrea@gmail.com>
 <20210126115641.2527-3-parri.andrea@gmail.com>
In-Reply-To: <20210126115641.2527-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-29T00:35:39Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e6a129c-03b7-4944-a7c3-d93941e940b5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [8.46.75.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08c33fba-f3ba-4697-e804-08d8c3edd35c
x-ms-traffictypediagnostic: MW2PR2101MB1019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1019CB727AAF632000AC63C6D7B99@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NpNfL+GAGbVdMtsHmuV1meKn1fVQCKzr7lS6zMNhBCd8xgTLDJ/biVvgfSd/z81TR+4kOfrW1i3+BlXhGdG3TssqjoTKXmCvoPkIaQvi8pdem7FEp/KODPbXryLbwAQm+xDss+IBBEmmTwr8SYC68qMIDxWTswEPW2jmalhGM1TK2j87LHqLdgiaUMxxm94OTb0xTcD+BRIpKI3mmYlj7GH3N7RBrcjlqKBHNvo8YeHkqaf9FClIhRFPXz6/olX/7wPJRwiBreasBAOdsSmAe+Qqs4wCHhojawGQ1BpAM8iBmQNPfmonsKz3QRkMw1rOH8b/fN85gH/5FrPf0oA+44z/BskS9JfXmUlg65C4XeD9NeIN/vMiWrZ3IDQespPq8KOYcFeu1FVTAZPJYDdptHoUNbTadsiU5PxIAjfUW5d6otvsMtY94Cj32P0/N+uSRwtf0tL/XCKEd8OcvtWfm2+p/wk5KYa5I1+2vlsh3gtjWSdNqs7TdFBdOOSNskb+0f/EBhHDdFN7MoQFfiV2hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6506007)(64756008)(66476007)(55016002)(66946007)(7696005)(76116006)(478600001)(110136005)(8676002)(8990500004)(66446008)(83380400001)(33656002)(107886003)(9686003)(71200400001)(52536014)(316002)(66556008)(5660300002)(82950400001)(10290500003)(82960400001)(86362001)(54906003)(4326008)(186003)(26005)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c/HKHDf3CvN+sLhvQCyseq8+X6O/hnWlR5EXTUPm3uR0bJZg3RUUBmLHCZfO?=
 =?us-ascii?Q?AHcDG+zSmgmNbKAQRoWrIKPDSN0/n6PEG1EZT9vciq8tigPO+0oMMfptnZI2?=
 =?us-ascii?Q?PI9ToFI3rUGaQUMmjfdbs4mwfTmkkA/8GpmgP0/v3DByTRKSm3Mxj6BHm3qJ?=
 =?us-ascii?Q?C3l8SmgYf5AeI4Sjg9uF5SNGlxS4+HGKNRAUVENJyjKKvVvRmn7U7j2mGOvB?=
 =?us-ascii?Q?eu+xW4pjZPxYW0DCVNH8mhkpIw3HkDSGwDo+3L/qDA2Ar0WZr/4IM0pC9yIu?=
 =?us-ascii?Q?nfgaEVJtZIOK9K12IH90eZspBpz2E1bpatjGwcPuLiQW83OtX7h4+7I8LDUj?=
 =?us-ascii?Q?cfaSOGFr16BMfAr7wB+iK5HUOm4dAz/7E8y/vEuj0DyA61MMh7VLlEKrGjqv?=
 =?us-ascii?Q?xKdM2GptVAFa82VLnaz0uJCJQkHC1xV9825khAdxqBCvemVXTi+YFSaRcxMy?=
 =?us-ascii?Q?HkRH9WfkMZe4yJFFG3oxIm0WqC/XdebenbLGlF9SaDNiK8cTsP1EV2gNs1zV?=
 =?us-ascii?Q?6xC4FUf1XnsMoxk+5EfaovbpOmTvmMArgOTrhn33dq1oDZdMJoiwsTogISaL?=
 =?us-ascii?Q?It0Z+12BUZieZTHHIIE1JHIVaInmVhQRvKZ/eSFr5IlZseWrgbgtoTp1FXMR?=
 =?us-ascii?Q?A714nMOL7WtKKUX+LxBrBkZktGFVZInPnFW5NuRvJ27V7RF3FUe8ln8q/Tcl?=
 =?us-ascii?Q?EsMNr7Z8GUywHnFxftIvQBKjRfHzUZDEpanREmH/DDNjBOj6J4sd6AoooEBw?=
 =?us-ascii?Q?AO6C7wDoJKoYjBbWWRbghpwg84HU/N74OoPUYpmcZFJh5zpMkPG01/KWV/Br?=
 =?us-ascii?Q?STZ8lYaFIZYUnia60aRxNExsRzGD2IiSs4WdMHjW4P1hX8u1+o/ID4Vgs1u0?=
 =?us-ascii?Q?ndcvMPRYTx21cXLR6FkoX2wRgkAEL0WI5ysWDSzAcWGSFC4wmWmmOwLvKdgn?=
 =?us-ascii?Q?2xgjlCeJ9zcjL33s2A6UgK4bhjNhUflzazRPDxcwK4k64KN1uUrcI8xT5V2N?=
 =?us-ascii?Q?XNRSoJpqlqK3O4Eas8NJkl9/KinIkyiNo1HPnPgXLpRgMKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c33fba-f3ba-4697-e804-08d8c3edd35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 00:35:49.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2g8su5Q9+VTRCLAecQnlM0npgMIaSyuRxxqVg/n99Q6i4crnVSVpCXleu5WIHu8tIfkq4JLJt/5UJSPemF9bv5k/QPGil8nwfuk4EQVpk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Janu=
ary 26, 2021 3:57 AM
>=20
> Only the VSCs or ICs that have been hardened and that are critical for
> the successful adoption of Confidential VMs should be allowed if the
> guest is running isolated.  This change reduces the footprint of the
> code that will be exercised by Confidential VMs and hence the exposure
> to bugs and vulnerabilities.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h    |  1 +
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 68950a1e4b638..774ee19e3e90d 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -31,101 +31,118 @@ const struct vmbus_device vmbus_devs[] =3D {
>  	{ .dev_type =3D HV_IDE,
>  	  HV_IDE_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* SCSI */
>  	{ .dev_type =3D HV_SCSI,
>  	  HV_SCSI_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Fibre Channel */
>  	{ .dev_type =3D HV_FC,
>  	  HV_SYNTHFC_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic NIC */
>  	{ .dev_type =3D HV_NIC,
>  	  HV_NIC_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Network Direct */
>  	{ .dev_type =3D HV_ND,
>  	  HV_ND_GUID,
>  	  .perf_device =3D true,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* PCIE */
>  	{ .dev_type =3D HV_PCIE,
>  	  HV_PCIE_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic Frame Buffer */
>  	{ .dev_type =3D HV_FB,
>  	  HV_SYNTHVID_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic Keyboard */
>  	{ .dev_type =3D HV_KBD,
>  	  HV_KBD_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Synthetic MOUSE */
>  	{ .dev_type =3D HV_MOUSE,
>  	  HV_MOUSE_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* KVP */
>  	{ .dev_type =3D HV_KVP,
>  	  HV_KVP_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Time Synch */
>  	{ .dev_type =3D HV_TS,
>  	  HV_TS_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Heartbeat */
>  	{ .dev_type =3D HV_HB,
>  	  HV_HEART_BEAT_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* Shutdown */
>  	{ .dev_type =3D HV_SHUTDOWN,
>  	  HV_SHUTDOWN_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D true,
>  	},
>=20
>  	/* File copy */
>  	{ .dev_type =3D HV_FCOPY,
>  	  HV_FCOPY_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Backup */
>  	{ .dev_type =3D HV_BACKUP,
>  	  HV_VSS_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Dynamic Memory */
>  	{ .dev_type =3D HV_DM,
>  	  HV_DM_GUID,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>=20
>  	/* Unknown GUID */
>  	{ .dev_type =3D HV_UNKNOWN,
>  	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
>  	},
>  };
>=20
> @@ -903,6 +920,20 @@ find_primary_channel_by_offer(const struct
> vmbus_channel_offer_channel *offer)
>  	return channel;
>  }
>=20
> +static bool vmbus_is_valid_device(const guid_t *guid)
> +{
> +	u16 i;
> +
> +	if (!hv_is_isolation_supported())
> +		return true;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vmbus_devs); i++) {
> +		if (guid_equal(guid, &vmbus_devs[i].guid))
> +			return vmbus_devs[i].allowed_in_isolated;
> +	}
> +	return false;
> +}
> +
>  /*
>   * vmbus_onoffer - Handler for channel offers from vmbus in parent parti=
tion.
>   *
> @@ -917,6 +948,11 @@ static void vmbus_onoffer(struct vmbus_channel_messa=
ge_header
> *hdr)
>=20
>  	trace_vmbus_onoffer(offer);
>=20
> +	if (!vmbus_is_valid_device(&offer->offer.if_type)) {

Output a message in this case?  It could be useful to know that an
offer has been dropped.  It might make sense to rate limit the message
like in some previous patches that are doing VMbus hardening.

> +		atomic_dec(&vmbus_connection.offer_in_progress);
> +		return;
> +	}
> +
>  	oldchannel =3D find_primary_channel_by_offer(offer);
>=20
>  	if (oldchannel !=3D NULL) {
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index f0d48a368f131..e3426f8c12db9 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -789,6 +789,7 @@ struct vmbus_device {
>  	u16  dev_type;
>  	guid_t guid;
>  	bool perf_device;
> +	bool allowed_in_isolated;
>  };
>=20
>  #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
> --
> 2.25.1

