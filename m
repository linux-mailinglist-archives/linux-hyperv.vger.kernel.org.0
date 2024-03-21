Return-Path: <linux-hyperv+bounces-1810-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AD885EC3
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DFB25072
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F285286;
	Thu, 21 Mar 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PYuJlswX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022010.outbound.protection.outlook.com [52.101.51.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312BF1804C;
	Thu, 21 Mar 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039391; cv=fail; b=A5VG9BsZSKkIA4n2her7BBqAVBftclzOm9YKfSiM4Xpn3xj+EHCEf/1dBvOpK1CATalPxE4d3Mh8sBprwuYK985ZDosEnhHcd5OsBDHU8XrLbvRTxTmXwLilGltcA2Ot6vKEF8El1j2/UcmHXSSH3K80Jfa75XBLefQRc2T+gdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039391; c=relaxed/simple;
	bh=AKHApDJmJLmlA6jbbYKSd6bekX6hU6VLZ1ecgoz0DNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dcbeIGCHpZky8nK7oqJ/DbQjIQfUy1jxyKqx7WNc6b0J7qg+LKmrUijNBAPh6OneHJdOqhkz2K3YbMaM6qYG2+ajKksri3wlJq3UTC0j5OKJMcZuR9GWP83B/aL5UPzpkPrxzk4OT3ke3tb6qXX1X7lBC3gR7pzww2LSZhw7j+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PYuJlswX; arc=fail smtp.client-ip=52.101.51.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8E76L8CCiZbSwueMY04gnfVudAt2XYTkTRpk2cASfQAfyGdhtLv2xO8ATAUTeJnNMQF47oYYnTzWw4S32xIA+rTl3Gq/fDDxQOAvMTRITjOhmfqJZAigRMTHxCcOpCtgi5Fmxx9uHHcNGLEiatCTUg3QZ7DYjdjn4kV953qOKgfhnayGQBRTWW5lfhZMHdJ9GPWujmHXZLGczJ46NDJemPlTGJYu2uuT6fgp6VKi89zEO8PQ6O8KDU0LfQ5qBIbYjtuQpQltjB58vMpw9tq/8Fw/Hvp/QeDZwa5cGbNlurQHBgWXHjlyAx+X09hfEh06eGhIDWPBT9DVyJzmeyT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBYLvh5fHJlkw26b1T60p9VKaDxbcjzC5BikvtT7J2c=;
 b=frsH1ucMM+Ed4ADKNHIIpmMIdvytJWkvK7dUsvhZRVKHXvvh1dTEy0zIP7RvocL2LdqAtTkPPKtnZgRXg3ctE180COB13F/qs6c0aN1Pw6/0CqbGmdst6bNuqxmaFkc6/ki65/6iZ3ncUpATHTGIWAQNNdyYsUMtrR7JSHHTpO3cZn1yDtDC51y/Z34xqvu8yvR8zcMBeF1A1P9nWrZigQmRRwuSoyYdrWFTqtiL7iTzndOC3BlT9w1CfxaPBU7B+5Y19By46oHSioN/RU+ohuvF0B+CmX0pY5sy+L8l3CYmuP2+lnIH/ErCdxD3eP2WqQbt9dF7MtavXia7rqyvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBYLvh5fHJlkw26b1T60p9VKaDxbcjzC5BikvtT7J2c=;
 b=PYuJlswXNlB4VDD/C6GrbK8qNPHWzKYmeSZya7FY2+Sh1oO8p2OFkAI0n7LDdXUCmqLtE/5r09+E2Lynzu1v/lK55aYKHiR30rznnBGj+x21PAenrAmi9f5v8hrzXe3pVTxZpVDhgf+wsPz2/a94/5IPSUe5ex/Bht34ZveLxfY=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by SA0PR21MB1962.namprd21.prod.outlook.com (2603:10b6:806:e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 16:43:05 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 16:43:05 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2 5/7] tools: hv: Add new fcopy application based on uio
 driver
Thread-Topic: [PATCH v2 5/7] tools: hv: Add new fcopy application based on uio
 driver
Thread-Index: AQHaerGMxvAnQM2QGUadCBNqLuvFZ7FCZVFw
Date: Thu, 21 Mar 2024 16:42:44 +0000
Message-ID:
 <SJ1PR21MB3457E5B4D852A914CD691E53CE322@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
 <1710930584-31180-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1710930584-31180-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8e94552-1fa4-4089-b6f0-ec16c1cf85cf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-21T16:32:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|SA0PR21MB1962:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 THc0mv1SD/WKJLrnMaDUfLJewZGn2CTNsGxyplWtsoJm1SSk7KiwXXs4ayy3h2+bUe8f4x53ei6XOsL7oEyV5mlJiqYpp+0joDubzWqmAWgxM3nhSnLbEW/07Pvsxs/FPMIkuodkjcCTmWyLV7SiJHzHfl0EIBK8P00QMn0Kc03d6x8dOuIXzEx5+Zv6kdHrF3AqvS88vufwS0dDxmbAU3fkzkGp4vKI1FXEvUVrSswTw3E8YlU4BTRlxxmJqYo79bxPgLaeWA6RJTUM23rpY1fwaBkoeFDer6/K9/565JbWY+J8gp2crPqQoJf+V72nOF70Ixn2XkhGoeRYsiglzLamhL6GMOn2cM+aDD5wLXRFZZ4f1BW1XQ5KsKDmNTgk+kfPOBQ5WIAv39USa36nW0yv6HafFC8kHjE7QixpC042Jr8LCG7fvuOpSuIdvkDWYlYrnZsq/kUkuQnHjCYl3Rl7LuBTF+KTlWGkIB9bPDvc6wk+2EGvStp4Ag9t3gL8BlopTs6DiYNR4zUikNqpGflGDjC8SJY/+XGXwka6HXEocLnNSadSAnf1ajscxGgI4MADcxBRazIXBBB/mFkPkiNZi4Uv1H7+71ttZwmEtuZr2KTWDt5QeG1GU/X8TM7HYZIxqSMwyrWpmMzYCCJA8YdHs15Iinu3boaV6iYihkk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PtfdrgDEpfQCqnH1ZTSR4B5n8J1/XotDX+Ad5GsPt1kaAJCaV4E4fpSuoKK9?=
 =?us-ascii?Q?lmyBtEP60jOXCidHQikBcMBkM7tnlXUv8OY07eSnRh7xKFVg+TiSKfloKoE7?=
 =?us-ascii?Q?aHnLCgf0Cr+4z0xQ+7O/6W3biCQolyPVlzQjxadyBXO/DzU7tg+9/ddOFKP2?=
 =?us-ascii?Q?HRU3dA2pTFXVg5gV1TGSmXZ9ZkK1c0VTNfp/rEvgDVTeu4SrJK4IjTuL5YB6?=
 =?us-ascii?Q?PadvlBBPZ+Fj8oKZ0NQJSkN1BqoyUFqO4JihO7oA5eSmfQuRtSJLm0/EUUuY?=
 =?us-ascii?Q?wtd0LyrH1Wif83M9an12fZq3Gs+vKcwEATnfEH7+/PwRuKVxSATTkeVI0zJ5?=
 =?us-ascii?Q?zdxUtno9/Zblj3rv3A8gXgZI0v3JGfCKyiZEE6JV5Dlg9F7GjLB3qbkySQbx?=
 =?us-ascii?Q?EqJebpi5EJkhzocSkDRZ6oNLhLJTOiyasMDtLU2qBjywWOhd6WIfLdpoM/2g?=
 =?us-ascii?Q?kvTo4MJFStQBWznw4kWZ/g4AAv59hFtYTyCPWczGz3qMAwMO0IVScqFu/vct?=
 =?us-ascii?Q?d1xPIoseW7nHYKXVAF7WXMxdmz+EyU8kfZr9P6/MzhtrrexfP1aNe54p4M9x?=
 =?us-ascii?Q?4sVnTAacxZeiDnybpIWK7XzpWA2shv1k5ZLZEhUTWV0gz9U5HV2Fh6fRA1Ri?=
 =?us-ascii?Q?Mvqe36yQenky27lKpLF/Jzpx1Ix/M7Bxb3zVGyy3FC5jx4t7QIh27Q6bVSW6?=
 =?us-ascii?Q?0x7f9iqS2BVAFrSpmK5CCobuzGCyV0Gdv6QLj5Z3gJdJXSy9XM+REed212Iv?=
 =?us-ascii?Q?DXaUcKB+1sruQ6ah9UGP6CVq07xR4QZ4aHaS1BCS4YFIMYzMUBHLsr6tLomQ?=
 =?us-ascii?Q?05qN73N/TICTfZCjkJMH6ex1dZYVFlpBCXEqPmfpdCrj3C0cOvlmskIjKRbI?=
 =?us-ascii?Q?X1G7DA35wgCGVWCoeatn5HRWArk7nBo4+s5bSWB9l+EsqYFEqtkOj7RHMC51?=
 =?us-ascii?Q?nHzBnFycGgdpdNVGqS1tJTCjlZgpmhjGckzpikcEI73j+sqRKMKNLDBy0cnk?=
 =?us-ascii?Q?UUj8K0vZcLNJp+CbuYydeybh7aUrauEV1EcH5q/VIn3ui9EU89p4q9CzINMX?=
 =?us-ascii?Q?2SUq99QzCZ/VgPGluvsFPfq1PbSz++uofHEgxo0XBsbbEc1tPOoGR4JVNbH3?=
 =?us-ascii?Q?vDgKhfpmJKkJ2XTvnu84iVhQG8BtprIO5NaRSgcXK/Lq07cWJ8d+8PTfJVmr?=
 =?us-ascii?Q?JlRxDLbHTVg2g7kII5kKPl95BTqKg4CB9GYOVHmgUowJSRiVR4U2Fu6hE5Z4?=
 =?us-ascii?Q?4YSYhOh+T2wW6kzQVdT96eKjkO350EPu0gLrTxDVoXUno1y/0vNFq9ZIiJhz?=
 =?us-ascii?Q?RX0UhSJWSgqzLfuDtstjXfbuB8XuVgywD8aoy5wEIyBakuEY/WqxuOoER+gs?=
 =?us-ascii?Q?3sQlnnTLi0LhYpQrhA8KFufkrqmSDqXeaNSVMOtBYKJ25lsWX6mXJd/63w/1?=
 =?us-ascii?Q?fzvJGaFOe9997boLcbsG4gr0K26hA2cth+hQS3gN7v8ETdOJaAYTZh87yqz0?=
 =?us-ascii?Q?/VVkLjDmS+FcesWG48Yc6cP64mbNgDeO+AFdceZOxzWOmE3SaRIV3S8ybmxc?=
 =?us-ascii?Q?YWs17x8KqP94jzBsMAzLCRNpWRhbvxLTDsgbjrD0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e41aae-46e1-445e-1d91-08dc49c5ef02
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 16:42:44.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofpFS0cMtsqq6Y4d89WRzaVuUc/Ha0/cmdYkg7LQFhWNUpGAjcZBODnq6iTMAdC2RBUPRgf8vn42HnbIu22WMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1962

> Subject: [PATCH v2 5/7] tools: hv: Add new fcopy application based on uio=
 driver
>=20
> New fcopy application using uio_hv_generic driver. This application copie=
s file
> from Hyper-V host to guest VM.
>=20
> A big part of this code is copied from tools/hv/hv_fcopy_daemon.c which t=
his new
> application is replacing.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V2]
> - Improve commit message.
> - Change (4 * 4096) to 0x4000 for ring buffer size
> - Removed some unnecessary type casting.
> - Mentioned in file copy right header that this code is copied.
> - Changed the print from "Registration failed" to "Signal to host failed"=
.
> - Fixed mask for rx buffer interrupt to 0 before waiting for interrupt.
>=20
>  tools/hv/Build                 |   3 +-
>  tools/hv/Makefile              |  10 +-
>  tools/hv/hv_fcopy_uio_daemon.c | 490
> +++++++++++++++++++++++++++++++++
>  3 files changed, 497 insertions(+), 6 deletions(-)  create mode 100644
> tools/hv/hv_fcopy_uio_daemon.c
>=20
> diff --git a/tools/hv/Build b/tools/hv/Build index 6cf51fa4b306..7d1f1698=
069b
> 100644
> --- a/tools/hv/Build
> +++ b/tools/hv/Build
> @@ -1,3 +1,4 @@
>  hv_kvp_daemon-y +=3D hv_kvp_daemon.o
>  hv_vss_daemon-y +=3D hv_vss_daemon.o
> -hv_fcopy_daemon-y +=3D hv_fcopy_daemon.o
> +hv_fcopy_uio_daemon-y +=3D hv_fcopy_uio_daemon.o hv_fcopy_uio_daemon-y
> +=3D
> +vmbus_bufring.o
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile index
> fe770e679ae8..944180cf916e 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile

I'm not sure if vmbus_bufring will compile on ARM.
If it's not supported, can use some flags in Makefile to not build this.

