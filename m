Return-Path: <linux-hyperv+bounces-1894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB628948A5
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 03:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8E11C21497
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BD8BF1;
	Tue,  2 Apr 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jaFbhW/+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021007.outbound.protection.outlook.com [40.93.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAF3201;
	Tue,  2 Apr 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712020994; cv=fail; b=XqoOL780H8XTexRoldL0MNIpu+1Z4PBVUEz8VGd+l559cXS0oDpalzpK0Az4Ptl47C9uh7rHIeEIg3j9NlPaoDcMvzA9TsO+cT1K3PtdsA0EIms+sZDdDE6XkOnfK1BBh4kPWVr4bsbFlqGWsR9wx07ZDo/WHUtzGxa8Cdsn8E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712020994; c=relaxed/simple;
	bh=jvohF1KZF2FVEQ5NrQ9XcahE6mtm+H3uD5pRgET/4rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=drx1g3hmsbpffMKMNR5efWe73YwwmtEKcrIu9VahTMEtlXcQmeZRxab50mnIsdENewDhmIL9LdYS14F52imcNJLiKMJb0mMSgX6ZREuX+mbC9PUEjvcY5iqQAbwhbhpyyfh1cDMxyy1j8Fyv9ZfIp4lSq8iQFV08xzaHItBq0Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jaFbhW/+; arc=fail smtp.client-ip=40.93.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAkeSHTqBFxIdkgjM9fClJLpAgqxEpsP5Q9anwc90IhMQkafGUO6dNKbL0n0kqX3KVZ5CYo6uWCLKmGEIR7QHrT15xw/saVBuwrfWvd184VVuO6eshwocmu+VQ9oQW85jyixK2gl/BVOM+Fb5veDoN7RkWurvUyD5y0zkn9L155UIAc3i+pChPW8EPTYRJB/eYCJRImU55Go06LusO6bWCnwuyN/QX0Xg1OtRPatMPfC4a+uDxuKupN6v+9JPu7NoGEsCTgG3Euy7t/pn+GPF+MzAsrFMVCIoRO1LnhAL2IavcfOLq7TLhYq3jGUZSgM0v1PTrXZX4WiuFUz+s01Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JqC33zGfl6ZFNMpjHQXpdyqGqnLR0HtQABZvYYQN4o=;
 b=kP/w6hYZsm9CQSVKb1brFGCcq5rht+ddu1kBPaHo4y2o8tCxNLeXyu3VuWkxAU8yq0Kabzhw4udW8/3bZKHj5b1c2ahYqBK5nG85lrpP4OxTB/FcMVVDTQLOCqrTemSlJXWOJAmF/ooFth3pLHGg382AcdiHhgaPZPyWm2J83ouBpwPoCO/gUaPUsx1x55EKOFDvsJCst0UbUpyeyYhuYBFOpVj1QAZ2utdOY93kUfEHuF5DD9IOLXgqVVbd7JvG6o9xaDhQ/OagRr8VKx05kj8Llh+C1flec8NzPmPLJP7Pi8RriCc80d1jYS/RKoinE7hP+YodeI4McmSFcbcgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JqC33zGfl6ZFNMpjHQXpdyqGqnLR0HtQABZvYYQN4o=;
 b=jaFbhW/+98F1AIiKMtVV3UX85xbVTvmoPcsLAOHJiQEdiu2EgwGuqc10Lv97GSGTR6aSyyz6pUUh1Ar3nCq0RUeNZkG/Y5llPkECeEFSD5RKlW3sh/8+8zrUUjpbLL0mQszHcVyvgOHusVE/Wnw9eaUR60PoFd9YyxCw9KePLLM=
Received: from CY5PR21MB3759.namprd21.prod.outlook.com (2603:10b6:930:c::10)
 by SJ1PR21MB3531.namprd21.prod.outlook.com (2603:10b6:a03:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.7; Tue, 2 Apr
 2024 01:23:08 +0000
Received: from CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135]) by CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135%5]) with mapi id 15.20.7472.002; Tue, 2 Apr 2024
 01:23:08 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Wei Hu <weh@microsoft.com>
CC: stephen <stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Topic: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Index: AQHagiFTbDDISYHohEGBGDLC4qicc7FPUWYQgATA4gCAAB0LEA==
Date: Tue, 2 Apr 2024 01:23:08 +0000
Message-ID:
 <CY5PR21MB37590FD539C1E380FBDC96B0BF3E2@CY5PR21MB3759.namprd21.prod.outlook.com>
References: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
 <CY5PR21MB375904FD3437BA610E6BDBD1BF392@CY5PR21MB3759.namprd21.prod.outlook.com>
 <CH2PR21MB1480E02C74E7BB5A52A71859CA3F2@CH2PR21MB1480.namprd21.prod.outlook.com>
In-Reply-To:
 <CH2PR21MB1480E02C74E7BB5A52A71859CA3F2@CH2PR21MB1480.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=59ee9ed2-1d2f-476e-81a2-fdbc522a1f8e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-29T22:45:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3759:EE_|SJ1PR21MB3531:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rmYcf8koOrW/LtdGzjbIzpHN5dODGqqAiko6MVdhhc7ISwTwH8AIAL6uMi1AQpqSXanP8K1cRGnxDPMxIye9oYUPzXLgVM/s3Fi7arAoXcBwlZ1FL3YBCqOjmSFIhY6THi4Tsw00RTNCbpPDesPUGd44/qE6yENp4v3XAENGgaXJo/oXFIsQSSSTE+h39AgAuhIFLLqSH9cAZ1fBLc5nq/btpQJa6WJLFo4n7uV4t0uc3ia2hKuKIF+/EgqFH/uxoYlaVhaoTXYa7EDVMwQmqjgvMNBT5BQrn8Z9ftb8ZogM1CaJcsMC0GQjRHPjf0im89SW3dbV/CX/wWW9yMHSqAH+DNwrDHpMiEb81IuzSm/y/UgVBL6CRYFYktKiVmrmqD3SeMmdmp77GP9qlmXDe4JhUcOp2gq6b7ie017wnnZT9UHTwts4LW9cBcQ3UQTAD5TbAvfgT5mVTNuHj7sjcjOdoiHonyRogf8h10cGGemjjXhQ4UQfMgVxYzkaLUlWrcdutSx359sk5vZrtndAap5p67QnqdV8l+n47PZcWV9rIvRJ5WC6ZQsKKa/mTW32IGNkqZSD0ah1ZFp7rYuoHAkR9a33lqE4s6oF+2pacqHiLSQbHq9uFrQZi7yZQJgc1Qix719UGxnPFBNCKF8dZnId4YUbyi2B9Q67ljAk4WY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3759.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9qDMiw16jGqW+pZssGLuu0BK2/fjEgH65CQ138X9ERXyJejxx+DRVqvwb4gl?=
 =?us-ascii?Q?mS/zYWhCJbvAU6ZPqWfSwiJEwfMGM7BZ9qUFf7BCgI3OF68T5c7ypNfODVoi?=
 =?us-ascii?Q?8iQQBUxOs9abIsCCXmedTF5vJ5+uje4DpoVc5KmpKWDSs8b/n9z91nvVtVZh?=
 =?us-ascii?Q?AuaQZHxlpy3lQagKqDVEbYLDwHiFXUO80ctdOhLrOsE3nw8C/P7vQ9Z88I3C?=
 =?us-ascii?Q?uFBPpMNreVcuzRD4v/zA0K61fDXJHZLB3coI9Qh/9i1IHtvT4SPBzsLajUzZ?=
 =?us-ascii?Q?FRewa3ncnqnxjFjEm4vTBp9MI0Xb11oePn3jRiKHUKfodlqcHHLONlvE/Ka0?=
 =?us-ascii?Q?vaecxOTlg7pIMBN/NHIhasl6YnTXQFXCrJqdYE1kQj1YHMU7KTP8K/Hkv76l?=
 =?us-ascii?Q?GDWUcUHUmGma2N2IdTZA4L0SJsLJxN1E5QxalxsNlnBswy74As6xxkJsaVED?=
 =?us-ascii?Q?6WvNsHC5+/jUdxv9KniXxuwpx5yjZPdSL0sbYr9ItE/9PSS5fD1QAW1AsYp/?=
 =?us-ascii?Q?nFUjCaankfY+BxAHiFQeCL2CRWxBYBmtHn9kA98Ed6yO60rPOTJH2t5O9Avn?=
 =?us-ascii?Q?FgdRYv/AyAScAbd16hrSONvw8sbyS9IV896ZpkLcXZkc8r+53JfzWd+7eTG2?=
 =?us-ascii?Q?iVyMsOGCHU0Z0sWlar0z3fIFaodp6GBqIvAf8B1yL71hRYV8G0fY7Bzg+t5C?=
 =?us-ascii?Q?uqhtDc3R5cHHlvsXTPADGyQXHi7phsytQqrKQmSO7alQ22TOIvPuRqfJNOg7?=
 =?us-ascii?Q?UGLgNZyLfCc1FzCgPEMKr+9145nvcOcUsc7oDloqexQVurLziuKceRvzNOJ4?=
 =?us-ascii?Q?iafUsIrm4A4GJyNyohkew/bwub2HW1mxd/4JW55Rdx1Ik+Yv3L7jZis/ASDx?=
 =?us-ascii?Q?g32oBjPdylMR6RXrCg7ACdvTnhKRqzRO4rKeTVuP5i1WxrncXQa+rK7grbka?=
 =?us-ascii?Q?M1LpJPqXKjxSThUiZNiTRrvszr2sjmVKQmH0jFoOVlycvumEOq2eIfc8BDRy?=
 =?us-ascii?Q?ybbCNgcKzyq4Fkzg6Tu0Nd852vBxB2CHTwnjHnwFyloRiqNHg/M3S9207BTd?=
 =?us-ascii?Q?hMaVnFqbqmMpJ5jZMGD1zs9NNUrYk2cW+jQ++oSgJwpYCk7OrHMgYsW4V2cP?=
 =?us-ascii?Q?pB8KPMnmg5T+1OOTyS3Yv0im3SVB+ptm7VOfhalq56BPqMgrd3bipjq2RGNH?=
 =?us-ascii?Q?5HxXzpuZM/kMirTKk3uDODrqGSup+pvNNmLsKTe3rD7GZ89eUbmDgJzBWBBW?=
 =?us-ascii?Q?xGCql9/zYiQgrpWYZpomDQZqpYsKJoirOlWZEQFKGAFpYEITLc+jPk7PI23g?=
 =?us-ascii?Q?roT+aNR32SjFl7G3Z9Q8xhH8nvgbDdZHxe6b2V0Y01VhiRCHq7WuqvxLx3Cy?=
 =?us-ascii?Q?jM5GYQS8FaRzABGW77kvnCcaUR8RxbvaXzXkqTrOpWw3HUk/QibsRe0EzI+J?=
 =?us-ascii?Q?Xr1RyNmA5daRH9fAZ27RZ8eQ4H5UEw7WGTlqPgHCjDdfB4gT+yGoQkIMyUGF?=
 =?us-ascii?Q?a2BcvmbIJcShYUniBmmVzTuRyWAgHnVgQ1jiPxLNk2NU3DIipMFeGzCDcpNI?=
 =?us-ascii?Q?Mqiz+R+JVRMUohq2MUI7/JHPQAK6ZFRepK5AGSWPI6K5zUBTDxys6LiYloK7?=
 =?us-ascii?Q?S6TunUq7TBUW3Jy5WK2c2OYdBTsPBxQUwhvrHmSLXV4u?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3759.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b243c7-2c95-4e11-d78a-08dc52b3748d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 01:23:08.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8PaH9kqDJHybj9lcuOBrt4nbdWB9SCIwJwa7exSRSMMEqApAC+PfzYmst7pDxJSo/qmgdo+m/fuK0cwH+XgDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3531

> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Monday, April 1, 2024 4:21 PM
> > [...]
> > I suggest the Fixes tag should be updated. Otherwise the fix
> > looks good to me.
>=20
> Thanks for the suggestion. I actually thought about this before
> submission.
> I was worried about someone back ports the jumbo frame feature,
> they may not automatically know this patch should be backported
> too.=20

The jumbo frame commit (2fbbd712baf1) depends on the MTU
commit (2fbbd712baf1), so adding "Fixes: 2fbbd712baf1" (
instead of "Fixes: ca9c54d2d6a5") might make it easier for people
to notice and pick up this fix.

I'm OK if the patch remains as is. Just wanted to make  sure I
understand the issue here.

> Also, I suspect that a bigger than MTU packet may cause
> unexpected problem at NVA application.

Good point. + Wei Hu, who can check the FreeBSD MANA driver and
the DPDK MANA PMD. The code there may also need to be fixed.

> If anyone have questions on back porting, I can provide a back
> ported patch, which is just one line change.
>=20
> - Haiyang

If the patch remains as is, gregkg will send us "failed to apply"
emails for v6.1.y and v5.15.y and we'll need to make a backport
for the 2 stable kernels.

With "Fixes: 2fbbd712baf1", we won't receive the "failed to apply"
emails.

Thanks,
Dexuan


