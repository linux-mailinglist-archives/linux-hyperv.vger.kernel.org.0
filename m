Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24873493411
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 05:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349317AbiASEk1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jan 2022 23:40:27 -0500
Received: from mail-cusazon11020026.outbound.protection.outlook.com ([52.101.61.26]:18224
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344785AbiASEk0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jan 2022 23:40:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCT52mXTC05rkH3rc2iaYPyU3HbFz3OV/37Z1uHXyB5e8Sc1tLQlql/trPrm7M+7a9XcPpDlH0v7Ol1wzRUkor9aGqfnv6qRhMishGRek8G5HEVGmbikqL0vY0zyXLbte48YSGTID9Cs7Yk9lm5k/3wfLoSHjZPETAU4TF23IDQsIEV18U6eDsPRwmW6DRgBu5cHg995x78gMcJ9OByLBYP7zG/TqTe+qIT6BAS+IRGfJ1WPfglTsD6FUtj6ENusF2ilZS3FXKHxRMUZ9dEs85ruV2UR9tID3xRpsWYS50iPoMkvtzFug8kGQw+CNA7eUOs7vfY2o8u+Lbeu2aHkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEZlYsbYYBRAj035zTti05amPXhniRVBXhESbyi64Mk=;
 b=Vv92JNzDD4FVdJegXay6B0tqGXO1QpXv13YQiIDo0zTaMGh1gkQGLKPuxarQcgbyIzAVIfaguPMwBjFzUNDsxhHwipEPvMfshb+OUU6hLE13NPKZ2NEw3K23GktCiX/BTLATENio2iHPyV3RoyeQfOzOWDg6eX7pIrnZjDDwjpnAZp5lm0cqma5k1Q2AmpFgrZzpAPLpU6ge/9SVFeW1LPpz5UXNxPJDojNyctKqARcffRP3849cOL9tdNAg72d0fp5v5sYVi3QaPpuOGYPQJkHFxzWQvcjJ/U5clJWCH9ZW8W+0hJKJKVe68J0VKFPMikXhD10X9v3x7yw7LK7/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEZlYsbYYBRAj035zTti05amPXhniRVBXhESbyi64Mk=;
 b=J3hlyLVfIc/J6PrOTtUMl+mOCMOBzxIE0TRxpuoRp+xWDGe1M6r5rjWjjKfWZ59Zg4HcJlA4A+u3SJF4LxzT6gM/+90OJz9fLLFDm6Niph7nH70TfTEpMlvVDYknjJB6/8gdbYJ4cDagx5gmyuxWSwGqfb4YLAUmjVLOr16zw7w=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by MWHPR21MB0478.namprd21.prod.outlook.com (2603:10b6:300:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4; Wed, 19 Jan
 2022 04:40:21 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::b508:1cc:47b2:db82]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::b508:1cc:47b2:db82%2]) with mapi id 15.20.4930.004; Wed, 19 Jan 2022
 04:40:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [Patch v2] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Topic: [Patch v2] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Index: AQHYDN6r1AhvtTnnbEWF1gebxgChfaxpvaPA
Date:   Wed, 19 Jan 2022 04:40:20 +0000
Message-ID: <CY4PR21MB1586368DF27F62BBFA12F2BCD7599@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <1642560329-5012-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1642560329-5012-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1c17f38d-7820-4d12-a75a-d77200ca2725;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-19T04:19:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2071c1f-d1dd-4574-a7c9-08d9db05cd03
x-ms-traffictypediagnostic: MWHPR21MB0478:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MWHPR21MB0478DF6817D9948E82A2A56AD7599@MWHPR21MB0478.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RzCo+ohSjmyvwlRgoCtx0SdLzE80MWlUGVBvENcIvk/SX/tdhHADpE/W6gKU39wa6pjpNXV24WP+qbIHS6qH8lcScKr+APwXVSE6XWUBQ1EAOpgMDKAghzoCUHqrdBxML2IlSpvFP5DU6DpxHUP/MlolqVjjh4nNj/L+PRnObtidaVzjPDllFpi41esTUX7LhP8uGqiVNr7NSnCUQGhfapNM6FdiBoXnWWokcG/539+K+KKvZCrDzBIQVQBxXogQSBIe5dZqobLviyv26dvr2hbDWTfgmB/CVkex/8HZizk/xjzdEeiRF93X5NWU/RCTxg0p8yO86xMcH37dTwcn8yg6HZUp64ph0WoRzh6TwAUYRO39WI8G7lfEjefnltNvTkeUQhkUH4V62q5sqRO9Ozre3QxnPl6E37iMbOib1k/+gf6s4PD5GOZFtjEGCBhhdQIkGHstAoRzun1FrFzJ0+wFUZCRxEqL7+7Ukz82+jCsscjVLxwdtbN7/AXCR6WKpMv/iW1pQh0/uOo6UMWqBbBjKpm5BLGzkqu61TvttfFFqSIlpn34+MiVvm/+45ZjHMWOJn1EAZ6DLjJbPlRJPS5d/2BwAU/1Q9xIC7xd5SQH7woGRQMHhsPOgcRl4TacO0p/Sb8zk3SH8qRVrXbj/hd1eKmM4CYPkn200DCAm0hMOtM/oAy0So6YP7LXA74wrV1KClhpa12x7fXP7reIfW9PHBmaFk1qY/zIAAKf6qSzxYK3hlYrORwkRicStnZi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66556008)(8936002)(64756008)(66446008)(66476007)(8676002)(66946007)(4326008)(82960400001)(52536014)(38100700002)(86362001)(5660300002)(122000001)(71200400001)(10290500003)(508600001)(110136005)(82950400001)(107886003)(55016003)(9686003)(6506007)(7696005)(186003)(26005)(6636002)(33656002)(8990500004)(2906002)(38070700005)(316002)(83380400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ni8Mr069TsDXWd1gaxLYaYQHX3aTakmhlHJaFQ1GYAJx0p464hbBSchxqAZ3?=
 =?us-ascii?Q?d65VYows15mgdNq0j+Ckd4F5hC/Pu2T+BJSCy4mNYVMRjcbsqiegJ0qo9ERZ?=
 =?us-ascii?Q?r4Kr17RZRYgPGnGL8GypC16wIJj3b/UabDWgK7MnlkwSNldzlLHd0xXATGYJ?=
 =?us-ascii?Q?egAXQOlcBVE95ZOwrgNZmHapWmo/4b6Mjm6lrxD4hWuqeZib2nZ9RFTCtmsE?=
 =?us-ascii?Q?I6mClWkjGkEbxlsvxwwzFHdQ9KqA4U1si8s7MoF2s4klFm/bmS4lfihgBebZ?=
 =?us-ascii?Q?mlXGJxPtZEjhLtHuC/ng6XEDiPAEoH5MCKenOgJVuUirYU0BmAIoZGJW4XgW?=
 =?us-ascii?Q?rGIhFUfKNmmiKk3ohYZ5Z7LxvIygUkMMLVG5RoSLRfKfkPVUnF/FLuWLyttS?=
 =?us-ascii?Q?6tBltyjlrTm2pV30MH4a1pMT0h14G4YxBbG5VUbHgRXoGLXNbH/eDp7AE0QE?=
 =?us-ascii?Q?bfkWQh7cEJOL/4cf1eR93nMuxV1ioH7SQz5lDxdjDuh0wfXZkRUmWL3oQFm8?=
 =?us-ascii?Q?ZwPL3S9qp3rqEliZyaveZAk3XzvUP18FAli+y13s30PnsWMqhoEZifjEXh0o?=
 =?us-ascii?Q?TuFHU5JWYsNndWMApeTs8NzIIh64Oz1COfIDiZ5lsCDswEFgo+pV0d0JR65P?=
 =?us-ascii?Q?44kXNDoMibbm3E+8IRX0nNCV6rJJmCkedXh3XYpAoa2kzjDssxxLCsEIF/Db?=
 =?us-ascii?Q?nlCINa+kGSdDgrXpf7w6HRUM9XO4Xc1fEypx3DQumrzpadY9vbpM1QQt13a3?=
 =?us-ascii?Q?2cORorYrMfsE+IvSbhXcMcWSAI7UQjYjRnUTjJHTcX38S5QPsPjKb6OY06E+?=
 =?us-ascii?Q?41GCSMb805LfXXcgrrzwfJ7LWX4DvvCYXnVEloiJCMHTihB9sAaz1Jd5ZYkU?=
 =?us-ascii?Q?4G5Lqh24p1fxLvEaFeMBbLsdqMpy6EtRzCTUOnsWx1Itm5GAsv8GvXYZuBmO?=
 =?us-ascii?Q?CBQ6zjVHOEGEVDJMRiEL1+1ba3d8BRj6J+Jt0ESyB5/5x+5DcNqOAAJQqH5e?=
 =?us-ascii?Q?03g7OdYOVTUfqePc8XWiJINdbf2fAdXAOZC8hTuhejeE5lkeO9rGv/uMEguu?=
 =?us-ascii?Q?ok71mDXaenLemtVExWy1Z2hgXtlw7dlIIVrmrW7UxkNebCUgGEdLNg5ZjF51?=
 =?us-ascii?Q?EtL+L0d1XV0GkwCVR+u5X6vrmnYCCCHcqpkkCuIb6914vL9kCpYWvoerd7xk?=
 =?us-ascii?Q?TdtfOJzOskx9+vYd6Qy3mkt9gD5YoSRWljog6tAwvXLT8ufEKh2xkL1Qq2Ui?=
 =?us-ascii?Q?rxLiq/Cm9MnMgbaFcPAMaqL/118Ynv9lo/5uSngtaqytoTW8GQ1Ol5XiscCS?=
 =?us-ascii?Q?G/gHrmfKNoY93tzgl5ijO90t3eDvbVVCVGqXXcCp4pKBKUAYFzXsbc87SDXN?=
 =?us-ascii?Q?vhizW4kObC51ek43glgqx3aA56LDn7r2XRpRSZ6EZdSH7C/CgU+ZZH/CSLPc?=
 =?us-ascii?Q?FNjMBEm/pwt8hk217W5ckDFp9fGanWk4JfwFSsaQHtg9uZocqukQbWa3weL9?=
 =?us-ascii?Q?W/D1tNvdRaMWjIRcyVic4soOQFmSHOWqHB+exnYs/j9f8q6LI9E/jTf6n+59?=
 =?us-ascii?Q?mrZdDRNmzpsSzotkDFdYqLk5rz550bUm4HIh4eH4SYenQMqIcgUdi5uX1fv4?=
 =?us-ascii?Q?KMMZtWTaFc5xXZL57Iw1cZAheb6MESw09o7iIxEvY3fQDmR7pHFvzdul9BpO?=
 =?us-ascii?Q?Eb41vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2071c1f-d1dd-4574-a7c9-08d9db05cd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 04:40:20.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZ2CJ/q9eVKQ5O9XR0ifVe6NbAsDdv1rJ/z5e5tvaUgu5PMTolRu4sI1z0ol0tcR29dn5lEN6apLawvmvwh5/JziQ5umhyabM/Nuc3sPx/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0478
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Tuesday, Ja=
nuary 18, 2022 6:45 PM
>=20
> When kernel boots with a NUMA topology with some NUMA nodes offline, the =
PCI
> driver should only set an online NUMA node on the device. This can happen
> during KDUMP where some NUMA nodes are not made online by the KDUMP kerne=
l.
>=20
> This patch also fixes the case where kernel is booting with "numa=3Doff".
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

It seems like adding a "Fixes:" tag would be appropriate.

>=20
> Change from v1:
> Use numa_map_to_online_node() to assign a node to device (suggested by
> Michael Kelly <mikelley@microsoft.com>)
>=20
> ---
>  drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6c9efeefae1b..c7519add6f13 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2130,7 +2130,15 @@ static void hv_pci_assign_numa_node(struct
> hv_pcibus_device *hbus)
>  			continue;
>=20
>  		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> -			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> +			/*
> +			 * The kernel may boot with some NUMA nodes offline
> +			 * (e.g. in a KDUMP kernel) or with NUMA disabled via
> +			 * "numa=3Doff". In those cases, adjust the host provided
> +			 * NUMA node to a valid NUMA node used by the kernel.
> +			 */
> +			set_dev_node(&dev->dev,
> +				     numa_map_to_online_node(
> +					     hv_dev->desc.virtual_numa_node));

Double-check me, but I think this approach has a flaw in that
numa_map_to_online_node() doesn't check the input node for being
out-of-range.  The call to node_online() uses the input node to index into
the node_states bitmap (of type nodemask_t), and could go off the end of
the bitmap if the input node isn't validated to be less than MAX_NUMNODES
(or nr_node_ids).

Michael

>=20
>  		put_pcichild(hv_dev);
>  	}
> --
> 2.25.1

