Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0B35F68E
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbhDNOsl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 10:48:41 -0400
Received: from mail-bn7nam10on2095.outbound.protection.outlook.com ([40.107.92.95]:37985
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350004AbhDNOsk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 10:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL+Q9g3mZJEzw1vyKxNGqCYd24s4Wk2YxFktt8AmK0E1fTBXsmjUVbS2pd48r0KugjSHVSLD+PhKnHoy/un2uJZi4WYKSNRhstB6NpiU1vpcL3zpLOyoEZ31MZNa2brM4N4ohxScz8SLD04HO3VFZ6cdJ2pHSnV3EHgBpZNM93wpTfBszr+RTO2r4G+5mWEt95SVaVNFE/08uQQbM7ztiQnJqo0+mMe8PEshA7QLwwbabZkBISpmqt8P2EYAuKnn+ar2zFujhGvbvBeOqToPo5ztR3v7Ht7vXj5BWrcOadpz8kcKfa5WxHWdAHn/cMkpJ1Vw7i62sFsYQXw2cCgFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3Ni0iqduwLmmZFWEOZqIo5njfvBgRBQVFLkzYt/qLI=;
 b=juN3AuezhYIc4bcgcOXH8zYrfkWtPfQEFmGm0/244c3HmpHIdWGRCYjnKWW61b5qHFgsRu6hA4VZ3Qm3qqz5gpuLXlS0+C3MQeSIMRIKjDOWzSK24WLFZdR0bI8yB12hIKlHvICsiUdpPdvxxLsSWXgxrzgDotiopZe1F3CnzNLo+wHc8CdAyUG7uhuijA/33cBvm0M/YXPpIIsmNurf99dypO8rwthMPnNRL++nJcnpo56R/kw8CeOOkHrju7y1vLVrpXkj6IP3bNP7eEXjROmSLMJIUh/rFumKaAQIvosh+dFZFcRpYZSDcWUjB81yxpaAJ0hviYEk/yUPywyqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3Ni0iqduwLmmZFWEOZqIo5njfvBgRBQVFLkzYt/qLI=;
 b=QmY/8qKlMd5zXV/VxFUsIt+EM5tj8cUx3v5q1hxP/3s6YOWUIEREkKvzzgbPKBFBA/lln6z/QSSJghSXpPB93fvVPB0IUzdkS4X2FtgegmHTBuQoK0/RC9nWkvHdl8wzVeldiKiCYiWM2pCTz2cTE6eePCClPgorgf5EnHKU1Yk=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1986.namprd21.prod.outlook.com (2603:10b6:303:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1; Wed, 14 Apr
 2021 14:48:18 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4042.017; Wed, 14 Apr 2021
 14:48:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: remove unused function
Thread-Topic: [PATCH] Drivers: hv: vmbus: remove unused function
Thread-Index: AQHXMPZwdj49+AD/D0OboUEvwMG0gqq0F9jA
Date:   Wed, 14 Apr 2021 14:48:17 +0000
Message-ID: <MWHPR21MB15933A7D469B6FF2E60368A6D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1618381282-119135-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1618381282-119135-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a19d062a-37ac-4634-a740-7acccdc0698e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-14T14:46:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71789a85-0f40-4a51-391a-08d8ff545751
x-ms-traffictypediagnostic: MW4PR21MB1986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1986B7C33A3A0B4B52630BE9D74E9@MW4PR21MB1986.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awFiMKVoWFhzNMpnDiZXjvSRqoYhEtgJ6J3lfygw5sZlPFjz7TooKnFQms4en7G7LwiqSP+7OYTqZ9+fPBuwz5gLEYRNjrwVoBXm7rbWBsOUb6hcdDVf5BMCIscmgJ5TKUfP/9V7phwOl0D+0ibDBnDhYQcv0JixSrI4PXQVcHgf9y4uUW5cU8Vp5rU75zUTMfVyzhBK30wFGryzYRaPAGSYVq5b0yCMPcBsN31jcqkxRnRsu0SKDwVBL9TMFUmI9mEIS/14PmuzqkLwXunH6YTgl9gNVwEKDtcVJ+9tSrQe7qeTr68N5sAiAZnjCSgmQquMM+xkJRgM+sjLjn8T12g/4HRdF4yxCRHL8k4Ek4TiRn3kIkR4uOVG40hsJPFV6GjTva7RnOUaLX3GEra+YqnK6SabTcRENoQUzsMsYxxbdiEt9xS3KdUOt1fkAGsiVuSwo7w8SBn7WbHqnhLLrPkXVMUyiQew9JtpB/Bt1V4PehEQ+FhlthcRI6ZvR6kVJB+F+ryoB2ODvbm0K8/z50YARFpDHx3qSMUKooQ9I2VJIHmcJUu2oJdlZefA2x/D9FaS4mxTmzAfpWMV4ICCNl4Mp3ci7jWkok/qce8zdug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(122000001)(38100700002)(7696005)(83380400001)(66446008)(478600001)(66556008)(10290500003)(86362001)(8936002)(33656002)(6636002)(8676002)(66476007)(76116006)(82960400001)(186003)(6506007)(26005)(55016002)(4326008)(9686003)(71200400001)(110136005)(2906002)(5660300002)(316002)(82950400001)(54906003)(52536014)(8990500004)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lL4K2tOlWaehxF7+tb2QDVBpaVwWRKM+p74kWcpEYOkqz47pnIaGm3gN+7Ok?=
 =?us-ascii?Q?2cnFlECwoER4J5mjsqTI0kDQdwj9mcNcOxF2dh+cwlpR7hbKuwaa0qAtDo7v?=
 =?us-ascii?Q?azqPHqLyiR2Qq/wlcIIS1GtCKTHvE605HXDw6/DRvQotyH1LRvVJAKYYhgei?=
 =?us-ascii?Q?3JLoxFCT2e/nmo98a6GAnIQbT+7htPYiIdiPEaZs4ImA03yi2+zDC0c82Kc+?=
 =?us-ascii?Q?C7nFv9jpKfUCo5VUx1Jz+BYDfQia/rlrlry/p6vL/RcYirjaAnQkZ2BNO363?=
 =?us-ascii?Q?RDdUXXHg2KO6DUjIyic5evSUq1Q5EXbqu0w3ll66BTgyRl0JP/sTABW1yJVl?=
 =?us-ascii?Q?zqMq+k6EJZPxjPX09L6Os9fVJ6MG/62lNjiCwz6atHyM0pKH8Ppp/GrmnXdL?=
 =?us-ascii?Q?7wtop9qg4AROCUTl699nhY5NnMSsVHkfhUXoCZf2Mho1ZutPT/NpZpxxXqhu?=
 =?us-ascii?Q?SNAj7xz+tclKiCUs30HxA3Pe4P26PrbG+OwOPipccQx6R/uUYQhZcKo54lW9?=
 =?us-ascii?Q?OC4QC+M6DYLt5lPEwkXFYaViYsoZK7Dip4CSDCbnwL3dkpDHJoyztWnKjHi6?=
 =?us-ascii?Q?9r+w5HBTLLNq+nHQwGU5yxwS34pVUNV0QnedskDWH0NbesZ7pbW6nhro9+EN?=
 =?us-ascii?Q?VDof+ezWi04KgfWSBmg7A12+Z0r2T058O7wVeJ4qxSpZIrAl2UvkKPnaoR2Z?=
 =?us-ascii?Q?xGgKr53eBtW1OOn6GjVIFXvUgp4AO750zf/p5/e97QeqE72H0QF92Fo82PDT?=
 =?us-ascii?Q?rGQ1cMWZ8P/W515VEMrsrWUcjmh7AgLo4U4JedlcQ+CSH5I0WqmCD0GLbEoj?=
 =?us-ascii?Q?yVlfHQFzEa1/NgekHFTdiPZ8+uzQga9TU/j68w+RfEJ1OvLl6/aRt3MxwErp?=
 =?us-ascii?Q?qLUB3cfBeThZ+2ZPRM6iIeEfBlugKUS59lWeJPxhsOn5z7J5hktMDDE3k3DH?=
 =?us-ascii?Q?LuTS4P0oYm00VWuxpRXEUhOiHvv/SYj34LBDpufIIBOgGhwXqlMCXGNXjzaS?=
 =?us-ascii?Q?lN7kAK3pc3VyfwSZkiL/AGIlXagj+ivEhbzJGMqcRMF9/BK4fQQBOp6EujJk?=
 =?us-ascii?Q?9z1wWKeRhMMoj9+1abX9IPj/93X74spQzKFMS2eg0HVAfQvS3VUXX5YakHzi?=
 =?us-ascii?Q?wLmZ/VdSE33jXiwOdRI/1RkgmDvVi4Ti+2eL6RW9aJTtOMesIS7HRvAY7EXE?=
 =?us-ascii?Q?40Xk/vTFp1RlcO4QtSCfobTIDRGUvbEYgSRa7PFmayURUnw1Ci1A3Xt/+TYf?=
 =?us-ascii?Q?bDEPIPfdYuTTgeLWC7qLnRD5A22kTB/r68LO2+mXPE0lWIsG7DCi7+dHaKR0?=
 =?us-ascii?Q?2B8s+rQfw55smW2HPPQx0xB7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71789a85-0f40-4a51-391a-08d8ff545751
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 14:48:17.8772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OXn5yqFevLb4tNmBdwLsJX7IteeVsCsoB6KfZq6BBtFkeIaJjWffz2XTyrGmHpYcw2bC4F6bWOeHqwQefeFDxBWbIpRhLuKsTeXz4b7xEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1986
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com> Sent: Tuesday, April =
13, 2021 11:21 PM
>=20
> Fix the following clang warning:
>=20
> drivers/hv/ring_buffer.c:89:1: warning: unused function
> 'hv_set_next_read_location' [-Wunused-function].
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/hv/ring_buffer.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 35833d4..78d4043 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -84,15 +84,6 @@ static void hv_signal_on_write(u32 old_write, struct v=
mbus_channel
> *channel)
>  	ring_info->ring_buffer->write_index =3D next_write_location;
>  }
>=20
> -/* Set the next read location for the specified ring buffer. */
> -static inline void
> -hv_set_next_read_location(struct hv_ring_buffer_info *ring_info,
> -		    u32 next_read_location)
> -{
> -	ring_info->ring_buffer->read_index =3D next_read_location;
> -	ring_info->priv_read_index =3D next_read_location;
> -}
> -
>  /* Get the size of the ring buffer. */
>  static inline u32
>  hv_get_ring_buffersize(const struct hv_ring_buffer_info *ring_info)
> --
> 1.8.3.1

This function became unused as of commit 4226ff69a3df=20
("vmbus: simplify hv_ringbuffer_read") on 7/17/2017.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
