Return-Path: <linux-hyperv+bounces-8234-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88FD155E3
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 22:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00914300926B
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6332C306;
	Mon, 12 Jan 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="geUFfnC8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022107.outbound.protection.outlook.com [52.101.48.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04530F54A;
	Mon, 12 Jan 2026 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251796; cv=fail; b=oGsP+zNFUzI8QdR0K4si1VKbmg/+ioS6pESz0uG0ohw9STl4s5wZhJES2esuFGenCZ+bmIhovcG/9vXMc3i95VGFf+sFRdZlo6DxbA6WFn5whshqZfbsBFN551FS/vqbZ6OjGM3FL7KNHjZhO8zlYiXX2CoXCrUoz9blpMtgmhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251796; c=relaxed/simple;
	bh=xTS7MGGpJvC0Y8WlP1b/ygpUbonhN1u41WriLJGDGLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmBMDFyeUR0Qd/TMjXRQ8CxvZb/t/k6pD5snarJOQD6a9WXLFjL6QWcX9MkubAMHa2cbmZR1D837FGRJ8wlrfYevRytSkKFmFpC/579DcKlD+tH6mee1JZ/tM0npMPjcihUMxjrfYk9OB7+bUtyFVlxyNpkaHRxrW8DDBN4jFWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=geUFfnC8; arc=fail smtp.client-ip=52.101.48.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpLpFxQ9ttlEOZpLcpiw5j0TGZeJKfELZyQxKVEKrMCoj4+TESxFnz312NCVTH8QSB1Iw/yYSGIDvIga3hlh1DUPpW4hx/48ZP95C0VcPOA6MuRbQmlGX+PBI+Zvzv+ZFPPGY9IY1TEFnvSARMomASrr5lDC0uPJdSF/sH/Xg4Uxns/KNpaIz5cFROqISTipBnbguRgKjkhZReF7g2FXEpGJUrkQ1PAowyS3hiDPTAsKsX9s3w+LCpiFKrnUp3xDeDgLVMRp/zwXqhE07lKFZYNthYUs5uhVL9oaLy7iT2BKkCfaCFTMK75PijKc1ESP8TPebKCcHpRcgkuz91nHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5ZYdltgLjnNIbJf7uEwneFQClaiMBrRHKqKFsL/pJ8=;
 b=XDzYKxI6lx+5gBMXbPlmtCctWS2qJ5/FLzLUtlTv3TeSp0UYPNcWghIeH6vrW34KP6weL+p/bQo785X8y7bq9VE2X/+MOmyt4W8uTRL/RjpWkYL2Fs87mOpnf6c7n6K+QOQzd2uDfje6cI4YwNLJInWnP1Fk+i/QlEFS4ZY8upfIeJt4aZj1RbYPn0A0e108/qFnQh2TAA/1n86aQOVNiC6rKXMVWIvjJ0WNd0mUhDi24cMd0I7XbbCRfnWbd2IEj5DsFB8Gez6gB5X4cRQnUBWTyEMVTVNcZ0Nsc8njm8TYN0MqwLN9pCmrCgBCT8lzKQG5cxzWVBGNTkLXAinWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5ZYdltgLjnNIbJf7uEwneFQClaiMBrRHKqKFsL/pJ8=;
 b=geUFfnC8A1XyXPxryv/GlYXFd3Hutqf23O2yYpjGLJbailhVvOMlKYa+dtN8LTNOWmAM5VsByLXnFz/CKcvxXiCdbrNGzlzwbf+AFxdXk0qNf5JUaKieBDIfXap2AaWt6fW81Vi5IS0CXwvSwZBXjGW0LaEc/fyTfRrL1yCsRxc=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6034.namprd21.prod.outlook.com (2603:10b6:806:4af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Mon, 12 Jan
 2026 21:03:13 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9520.001; Mon, 12 Jan 2026
 21:03:13 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V2,net-next, 2/2] net: mana: Add ethtool
 counters for RX CQEs in coalesced type
Thread-Topic: [EXTERNAL] Re: [PATCH V2,net-next, 2/2] net: mana: Add ethtool
 counters for RX CQEs in coalesced type
Thread-Index: AQHcf02vovGckqnBaUyi1QeGJul7JLVKqgUAgARk5/A=
Date: Mon, 12 Jan 2026 21:03:13 +0000
Message-ID:
 <SA3PR21MB386767DAF624033E55FECA38CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-3-git-send-email-haiyangz@linux.microsoft.com>
 <20260109175620.3e461176@kernel.org>
In-Reply-To: <20260109175620.3e461176@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=432aca39-706b-43b2-b81e-0122a79f343a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-12T21:02:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6034:EE_
x-ms-office365-filtering-correlation-id: 1be41e4e-6e0c-4710-6bc6-08de521dffc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FMGhB4E7lG5cf8hsPnOha8yJDovwOykxBIdMl1LJqYCYebe+1V+cV9Gmt4Xa?=
 =?us-ascii?Q?ZpFHngBTzXUYz9QMLo9L5L9D6LCKLQrTMc3fc8Owb229LZbee98L35+q70HS?=
 =?us-ascii?Q?T8gjC68qHt+dTSOblaQIpMkmU0R5ibN9DbYTIxjZIaFApIKLGKulom+/TLoD?=
 =?us-ascii?Q?vJ2pX8SCcufSX2ZaBBaZjG83VRNl42pBz3rj19c8XS2AG2isJZ/l7zrK8Rdk?=
 =?us-ascii?Q?n7Tanp/u1h4d7oTCepEsJDdjbBShs0jvO8YPHxNgKYkB4P7JtL8BIZbNstsy?=
 =?us-ascii?Q?4rv6BhBv1I74uDxkd5VaIxKPiDgib18/84tegecI5THFN0cHcbMtYCq4QDH2?=
 =?us-ascii?Q?i+/d2F5MPVTOGM9VTjwMn2x5zf+08ph2rRL+zsYpHtdLKX+hvMWF0JlPI8Es?=
 =?us-ascii?Q?KcoyZoDcgj6+j+jBVFMb3+3cEumAIrgBXpj0LLK5IS4TEexlwwmg2ZnFvJJ0?=
 =?us-ascii?Q?1J3HRuSFLBPq5acvA3QZSuKrbdzUqeOjQmJRf66APk/A91G8Oe4opFNCruX2?=
 =?us-ascii?Q?HrYC6AwR7TlYml9zOCbbbfMv0oasivpBGBEvNWEXu2EXNWxMsu+ZhcsJx/Ia?=
 =?us-ascii?Q?YNhgPhSTbLI+vuI4HANN2aCTl76V8ZXUB1zhG3Y1UTL3Uz8oejvDFDI5xqks?=
 =?us-ascii?Q?nvCI5dQ4Ijs2Jy4Dv7+z2AjqopGSLw0CGLUAAIU2jAUVOt95Rm+yxecBZ3xA?=
 =?us-ascii?Q?bFU32QQKZjM/aCAPljnSaUicpFMeCgFSdU8qDHWy9NXfVXvfLDjtttbi2RHZ?=
 =?us-ascii?Q?M+ILKt37xBYmn+kwY7l22VXcsNNtn55ms4/wDLURp0rsiNOuu+iFYnCD1eT3?=
 =?us-ascii?Q?HxdXhGXozcSq7eSSnjylguYuIGuejUMqcP3I3BFibQUPei3z3M6g1W3ivQOJ?=
 =?us-ascii?Q?Cvnb/PjZUCuDDtE8cqpyuvW/n3cvD2F6TxnbLx820jt4wgC2JLllszugtFgI?=
 =?us-ascii?Q?uK4v5kKhCi0kHtIsczwDfGLZVL9OthsWGJ6ucSwkuliClxQzcmJwaukaqgX0?=
 =?us-ascii?Q?EBlCvTO5bQvYlfvIkpI/QGqH6f+r2AIscFOgvJw2/rkfIGxzM8P+TmIQBV1f?=
 =?us-ascii?Q?oER4Ux4JgUqNzdGrSwWcxuQ24OPtEsMYvZvILAeQLvsX9kxjGflHEm01PE8I?=
 =?us-ascii?Q?dVOog9QDMPzDghVKuDjPU6Uu521UdTfUrSg1RoT1sTOT7pO/vS5FmXqAnyfu?=
 =?us-ascii?Q?0FoglntRWwsZmERf4UVprvR5GUBGG4o8GOSjJ0UsK0BU0FQKk6oodGxk9DhI?=
 =?us-ascii?Q?Pjgu6j69zFZmDlNzorP593UUsYrB287D5VEewSWkHIl3Qjd+G1xptFjmp/6o?=
 =?us-ascii?Q?z5rTwi4ls7iKr6G5GWMk+0K6jPyPUy7cL6mPxzTl+oBVVUmlhHLG4NqjlSUm?=
 =?us-ascii?Q?39Yxd4KWurm5FWafOJG8nK7o0diRiSNY4Vfk9z0z9hTQ8okjUknl+gNIHP52?=
 =?us-ascii?Q?2x8vzFSStUi9K6SbL6zOpAoxWeOgxR+GNrdxciviaRCmQ7cljlPd+6PyP/Ha?=
 =?us-ascii?Q?oE7sxVauFI6GVBEtxruNMOOqaxhezXKCujJ2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xJvBXt7EA/Mj6RKRQyI9uD8dXdwoivTZC0wwezJXe6kRXYRvj926bfdeQTTa?=
 =?us-ascii?Q?5yu8v5FLWhhjM5dPE+DT6RLOhtYoX3Z9k5MTx0ru9w5H14JWHK1S6l7vPF0B?=
 =?us-ascii?Q?iW6Evw44QOvMk7XwSw1YgFAsfRzVp6rjzNzkzrLuISPZp+VGuxur7jYMUUrD?=
 =?us-ascii?Q?azDyD7Qvq+GgdkPW06J0Rc2GVv7ykgr86RkAZNMmMgfy4IyCkT8Qj0HRut2D?=
 =?us-ascii?Q?nr4JOxoLNZXOcncql2lMo/EomxS8KuVDi10ZdoH+pXh19ovwFNVnOIvRiBOe?=
 =?us-ascii?Q?aINCaUBl20WDEWN++9UR7HaYrNEF5aXhqkjBaxPHy/Jm5q3xdxxJiZX+u7/1?=
 =?us-ascii?Q?TgszvlAlAdBH1FGK/yg9MNAAjUKoo450MCupGWFUpIRjxdqkQeXYMPSDKp6q?=
 =?us-ascii?Q?xfQO7rDkEdEyKrDZpAgrH0Kc0Lvigu1WWLkbE1QhNf0YCiYh+K0R+qfAgaKH?=
 =?us-ascii?Q?AQT8lXtwTs/4nOA28H+4TgJkSOKFQa2UQ0Sg+8upiapTNDR/dZAbp3izXRZU?=
 =?us-ascii?Q?PeUbpePJtZCiAUR6VXoalhmwTJiom7NEDPuKb3VxM1uSFDRdYGWZ4BSqsYUJ?=
 =?us-ascii?Q?cxzSy55ueAb9R/qd3+cl7YOyKzYIHOR3OmnTJRgI/2j0diq6sFUiD5nJjnni?=
 =?us-ascii?Q?1AGjA0HdY2iIOa/zE8UoYNGZpXOjAA5FZr+yxWt2fB3DO0rfkQhLYOJRakMP?=
 =?us-ascii?Q?a01jOabYnHmnzkvSAE0PVNlUWndJwkYr/rezQq2ksCdr7+33C+X+yOxnnk/b?=
 =?us-ascii?Q?SNbUpMfGim86Ns3U0Au4kPPRqM5fkVQaGWvWPtBsepSzKz5bvLgWBeZGFAc3?=
 =?us-ascii?Q?znPipqCbFf5aCPB3uXiwJ8Lu7sUUXpouWeCkPMYgXKUH5YQ3A2v5nFL9NMLg?=
 =?us-ascii?Q?H8n8um14OSYrP4+qBMproZSFFla7+d7mOXvcIb2GniC2fGy82QkLSptgXHFB?=
 =?us-ascii?Q?ia8W74Nf9+vbSob1VdROS3Z3iWS7yANC8mnHElOByrcT+VFSLAUo1/m/Ug3q?=
 =?us-ascii?Q?8JxAhYm+h7j8n0MPTQZAK3vAxoZMgw+up1yNm6XHFUwAuR1oM69RQTGDFN64?=
 =?us-ascii?Q?hLrjFUiOhW7BwFfQHCQJ3tmC28gZgaPvaHFCUqga6Oj/vxRKtnVWjlSKdS83?=
 =?us-ascii?Q?5H2jsccbbH7C23stlpATTmr4titMgsq/PW4RHKDvzRsx2Utjra02FVZOqx79?=
 =?us-ascii?Q?MXEMCj/gtopzX3lH8Nosrm6d9Pf7ttp7S2LO+DMkPrWOfXSYV1cqqxFgMKKQ?=
 =?us-ascii?Q?RxIeyNjwClwwW5whbClyl97Ot/fYflUdxow+RLJrwL6uoQijSaU4Pec9wQuS?=
 =?us-ascii?Q?btbM88sGAX74+8clQxhNIcoy7BR5P4OiIjBy4hSIRsKqhby1zUOmTJZv1/Vu?=
 =?us-ascii?Q?V6EYiQr3jipjetg+28fR3K/8p7Ft+BNkiA+T7sm040rKc/k146ym0HImP31E?=
 =?us-ascii?Q?PXTkuxOnnP+Rw+KOfO8ce+xzGRjeHVtVOtCiCdYpccPBfGKkv2UIgNandqRC?=
 =?us-ascii?Q?VXGKHZx54aqHlOFGxWaiqjdN8iqCYTMy7yNnbqXgBQeoWpAuynoQ/F2M9THR?=
 =?us-ascii?Q?UbAhrd6u/vxgTn1Vo39iZVJPmzFtAXfvBmQDRDqo4NBNs73BS/+o0omTqrbA?=
 =?us-ascii?Q?9FsJdDZcuwWoCTjOIidNac9HV/bpFZJAJE3pgKB44ggmSiI5xF/2YHD8gm/O?=
 =?us-ascii?Q?50rYchE+dktMIStfaEJ+ueWor1LdOH2/lGKM7EOI6LdPrau1?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be41e4e-6e0c-4710-6bc6-08de521dffc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 21:03:13.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrnN+vZf4K7cZ0NaZLKMnZoXbfF7No6pb0kmC9EjZsV3J+uWh72eEuAD85psycun2CK6yQP4HtFkfhx+pIudug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6034



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, January 9, 2026 8:56 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo
> Abeni <pabeni@redhat.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> Simon Horman <horms@kernel.org>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH V2,net-next, 2/2] net: mana: Add ethtool
> counters for RX CQEs in coalesced type
>=20
> On Tue,  6 Jan 2026 12:46:47 -0800 Haiyang Zhang wrote:
> > @@ -227,8 +232,6 @@ struct mana_rxcomp_perpkt_info {
> >  	u32 pkt_hash;
> >  }; /* HW DATA */
> >
> > -#define MANA_RXCOMP_OOB_NUM_PPI 4
> > -
> >  /* Receive completion OOB */
> >  struct mana_rxcomp_oob {
> >  	struct mana_cqe_header cqe_hdr;
> > @@ -378,7 +381,6 @@ struct mana_ethtool_stats {
> >  	u64 tx_cqe_err;
> >  	u64 tx_cqe_unknown_type;
> >  	u64 tx_linear_pkt_cnt;
> > -	u64 rx_coalesced_err;
> >  	u64 rx_cqe_unknown_type;
> >  };
>=20
> This should be deleted in the previous patch already
Will do.

- Haiyang

