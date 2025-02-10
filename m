Return-Path: <linux-hyperv+bounces-3874-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5CA2F1F3
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 16:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111A4162848
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536B24061F;
	Mon, 10 Feb 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N0QD6wEH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022099.outbound.protection.outlook.com [52.101.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDC240616;
	Mon, 10 Feb 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202142; cv=fail; b=p8vKbnU3FBLTK0R45PcO8JhHtukQRqS80a+K9eIVEAbACLpoOPy018DcWpu1HXhPYw1pHlBRDGyH8zY71XhqinRDA8fPxfHn4urwAMzwFlmPYRjoPQColXUa9bXy1KB6260dIYHNzOFDuxvtmj7p7WRFRS4xFUIDgBI8lZ4g5oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202142; c=relaxed/simple;
	bh=Tegcy0CJKmW/t1v3/XLzEnJUTjOY8fml7iGSpCUVdVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NtAwcg8+bcW9UxbijqOi5p8bKMsKwXK91vbHPQtrwG5/tZuUUbYABw14YA73XonXWtxe/0O4cfHZBUNh2A319iFuMkcAeuDs6NYK0j6RvzV+iY6+DbEG2CYUeK1mvoSMeNh9gMX8a69YQr1rT0HXpWDq2AjDwzfKMzuHoDIS/UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=N0QD6wEH; arc=fail smtp.client-ip=52.101.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptCv+bVV0pAX4mnZ0kxoFWMmUk+/TREG4Wofn/zkH18mGmtXf5iapO9atZITh3z1aDyFcnLlCVtSdXZG7sWTeik79id3I+BsZBeo3C8nrFA8U8No8BSqILPtqkno679AyTk67nlu9aHnBtDUEIvSaAqxa3FPvdVDl4Cv0NjZ3lKonOtXmFrvfV5/UrQWHkXY2hS8q1YO6ilNPlg+GatcgJXfj9Qi8EoMQrOkByVjs2R8zeKU+DfgZ38TOIVVZPKY+5fhFOJaoEyXvlLQpqodnI13Gcb0UEVYyI0pPzEVvH6SMZO16C9P19YPosKsTZfgxbiy6a5WNclWXXyDa3d8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1lSUH8JOg+T6MeCXaY6K8P9PDJxZ2XxEWtozd5CkCI=;
 b=hG5Fl6qMBxZuU0z2b3JAEUGEKglPyfWAfHVEu/+AIPq14wK5lG9vC6sGT6Fq5y3EHSpKqvBqQVMswC5kK6XQ4d9Q5GLtc2TKNlkU+/30qsY3KZzyD//uUUfRevrk7KfSdjmteEfzoIPqLGcJpbsOUijIBtlMqUyGe6I0idcS6ly1YgAs/qEXBFR/xWyUTrKWD5aElBTeMuuG+8amaMPJ3LagEy+kIpvQYKAHjGFpaYu+GKlTJsXd6gRJtFV10KadVE2ZC36FfSRanO4LsWDsYBGNy21K10SOn0NwJWO/NIAeLJiTLpfQzaykFcbtLv3ztFES9ESaDpU6ZwJUpi37bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1lSUH8JOg+T6MeCXaY6K8P9PDJxZ2XxEWtozd5CkCI=;
 b=N0QD6wEHD5IsDcF5wvcdMlYNeU6r+1dFY1U9tH8teEv+oekqxuEKvFSTm2zoK5vigoDDRz8gV1mEolRKdcjVEsA3tGGWxxTMoXdXZJ9k/ccOfzNZrbUGGPAJ1s38CC8xGQQlfRrtiEAgB6UzOKqbOA79VZtjBekvpsk2WtAq4GM=
Received: from SJ1PR21MB3432.namprd21.prod.outlook.com (2603:10b6:a03:454::18)
 by SJ0PR21MB2022.namprd21.prod.outlook.com (2603:10b6:a03:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.2; Mon, 10 Feb
 2025 15:42:17 +0000
Received: from SJ1PR21MB3432.namprd21.prod.outlook.com
 ([fe80::9fe2:ba5d:6491:db0e]) by SJ1PR21MB3432.namprd21.prod.outlook.com
 ([fe80::9fe2:ba5d:6491:db0e%4]) with mapi id 15.20.8466.000; Mon, 10 Feb 2025
 15:42:17 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v2 net-next 1/2] net: mana: Allow tso_max_size to go up-to
 GSO_MAX_SIZE
Thread-Topic: [PATCH v2 net-next 1/2] net: mana: Allow tso_max_size to go
 up-to GSO_MAX_SIZE
Thread-Index: AQHbe3XrS5Tgq0LoYke+jzNRvidjVbNArYrg
Date: Mon, 10 Feb 2025 15:42:17 +0000
Message-ID:
 <SJ1PR21MB34325C7D269294E2BABD5644CAF22@SJ1PR21MB3432.namprd21.prod.outlook.com>
References:
 <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1739162428-6679-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1739162428-6679-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=db123c92-11cd-4db9-95e4-2474e615bd28;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-10T15:41:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3432:EE_|SJ0PR21MB2022:EE_
x-ms-office365-filtering-correlation-id: 40672597-febb-48a1-f5dd-08dd49e97f9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/kx+32bBt6aeY2bL5n7mwpAchL0cAqkZoBR+FKcEQPIaQgG8HcPr7RaQyk48?=
 =?us-ascii?Q?FX0o0eKSZ2lk0RzNytpIzOjKOjiFl+RZgmgdG18gJCrDwGG+YGReXHCwp5wy?=
 =?us-ascii?Q?i5GbfTl5Dpoh4vEQoDRRzqQO4cwSeO+lfHYf1hhOSuEC1wcOujEkR568nN+K?=
 =?us-ascii?Q?p4EwqAGLKo4DCaeFq9yX/ZInQcwm/oKTZ4A30hxKcjdYE4U1sXbldfTPRq1t?=
 =?us-ascii?Q?8YMCZgiJb8kzW7mi43eESyOCMPt++UN1Lw25VE4z7TkfuzE0rJmZmNgufkCN?=
 =?us-ascii?Q?NfbFOWHjOUOiYUEhfV9zcw6Ycj4bSxjJMft6bMgWlBmAVjMqrd2whXLwB9KV?=
 =?us-ascii?Q?Dsej0y0bGGNBC2ZC4sqYGMz3X5uwKAeGH4r181sWHcn1awdw/ZbfsskcLUtS?=
 =?us-ascii?Q?j13HkSKD81Wb6fM7Hf7psFURT/kKiV22Cr8yPvPoT9ZpSCKzzHIocr8i6bZC?=
 =?us-ascii?Q?xUfH8eyfJEbjtzab52xuQEQOc2ytxFnDVzSKHMwWlxN8Uw369aqSZx+CB/VD?=
 =?us-ascii?Q?Ih35aFnJMjMT58ajNWYvcLA5wz4mU+4wRfzT8K7p8kjG3tIfRP9FHhDXV6Vn?=
 =?us-ascii?Q?1gCpmV6LRiUZmaLVQtawlVexG8kLLBJD7xhejA8djhloAL6FdzI1bfsxVT0X?=
 =?us-ascii?Q?k0aDcjFYgSMJPSsrx756lnrDJZaCgtBNN+sJNfGiAB5tjeCI2vaY6Vux1yUm?=
 =?us-ascii?Q?qUfb3tX8mJiOSoYgrTF9t7eTAhoYCbDkmWOIxoppkr0EUr3goalu0GBTlKSY?=
 =?us-ascii?Q?5n84mfstCOqBr2lqyoraAw8jKZ2UKIWR0bxiOafg3/uT/fRRTnrYgI9tYcDK?=
 =?us-ascii?Q?KQ6/VlAgrcP68DdYceEm4NgXnMtLyn3OtrN2GbdDepCsnNW4zIbCH9Zw9el7?=
 =?us-ascii?Q?MEIbpyRexHFt4Szu155ttf5UBxR91EzxgOvt72Dg4RPIi6MqslOM8pM3/DBI?=
 =?us-ascii?Q?h2VRriGrmSX0rigfUPD9LJPC3pdYJrlknzgjYnuTNiWNmpnmGpZ9LIDwIbV8?=
 =?us-ascii?Q?c9DsMrCu7Ph/IurAyBnVLNevcOwVdhMX4NlVJrI32sHlhuGwa93lnxArXFN4?=
 =?us-ascii?Q?xIy2LCFk78odNC5duZ9czJ5gaCD+ysJoyi9J+vKN7IxpVMUegnK+Tik2ssJ8?=
 =?us-ascii?Q?4+hfKHyeYgd9IGBXVl7i8DIE5TWP7DxbnSWdKV3PqCZBCj3OAo9kmcveDy4I?=
 =?us-ascii?Q?JVIjfhtfZsapjXm4EPrScxZGvPPZbLYYl5ZLZNEbR65uV0F7gNCMUrwGm2+G?=
 =?us-ascii?Q?B3yi3jU7Z3J6aNNCwi1b0A/3JXrW871IJvAeJB36jPPsQTAxLyfZC6ei04la?=
 =?us-ascii?Q?kPHwonZUVqMWp/WuFdzQVKv197KL7mq4ymOl0X8yO5OUxntDQHJMJYM+QaVz?=
 =?us-ascii?Q?SeggU0WcWETAj/YDWURAtyDZi1/TZM52Dq244h7S7aXucD5YL3qdwb0cm3wn?=
 =?us-ascii?Q?qTscUqrypifld2QSSCS/YoXpQ0RMso5L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3432.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bCRVTGJ4uodICtGgAJbT6GvA0TVhuM5vSxlI9bmvUwh1meTXbYJu8bS+kg9u?=
 =?us-ascii?Q?H7qHA7VxEPgTew37Nr72DuknP28SlgzYRV4++hMZkFtJ+RQirWhP7Ayue+e2?=
 =?us-ascii?Q?S8GNvRyREmDXbDSDYPwaX3tuK6w2Rc/AmwXH7Ly3/vFCLJ84PWEyFD8CfY46?=
 =?us-ascii?Q?DejnHpgwHHkE0ANfhcDVhyJAGVlWNS2WBbQZK7hc2djB5+5C/4U3DAlTYWqp?=
 =?us-ascii?Q?HGzfTMzPZBFLLH+Id5Gk/JDfXfgkjq4r3IFqTdHOPzGhxsjwAkp7xulx6O2G?=
 =?us-ascii?Q?gbReJLj5SfXMkgsQK0USBG/hEusFcBjwzkPXJSbYGcC5nOM70l7hKKicu1oC?=
 =?us-ascii?Q?LgVxA5vcY1iI041Wh44REeaPImaBSbdKv6OpSQZXmvaSnz54pFyBW8hSYNpT?=
 =?us-ascii?Q?eUWSYhPIuvUQ2ah68UizbSc2VHFqQAsYvPY3KsFbGnHnTazsQS0JGTBhjieL?=
 =?us-ascii?Q?YpYsclrDtuxWnh9as38nAFRcKUU1BHKuKgY9K1PL6AS+BB+RQUEHCSdxIWxt?=
 =?us-ascii?Q?aL2azCUaWG1x+afzJfvLacRmlNzj9OiN97F6FrobTY/0BAkeI3YArw+/C1IL?=
 =?us-ascii?Q?s1czLaQxaHC9mSchC2gZLOiUcjZnIeVHvuZTxgP5E3sP7u240RvXKKLCRvPa?=
 =?us-ascii?Q?hAqLa79T4/MmZjsPIPM7uKSibhNlL+U+EZpLe1Y91O6WImoxdDGjO2pdG6OP?=
 =?us-ascii?Q?BbGjMuUJe5+3DcNMnEkXWl80+/vjdWqQ+EbQubU4x0X86Wf5SGFg+PZh/V5J?=
 =?us-ascii?Q?IQPo5z5Dx3p1tDnkpUyhBBEJgwaF3QG31aBvdDqc9S/7RrTg9zqM9uR8ZruG?=
 =?us-ascii?Q?r19bbny/E1D6GPpvNoO9AxSLDeGIGlAbHYW9a/K/LSQ9nf2qRFpZCrVS2Ga8?=
 =?us-ascii?Q?wGG0tu7NJ9W+cdndWrgDvmkgNypjQCfhFsegO3znZrFphCzzfZKipjHYfGW1?=
 =?us-ascii?Q?wd/pGuqh7ydeGOkktjhPbwSuEW+FfudpNoxlQ8P/icG2AANRcbh2SSyMdxy+?=
 =?us-ascii?Q?cx5EaJ9Wyj2Cdnh7KDVd4SNUL3OoVl+p9vvKpGgSwo+DcK+50jJAk/BxnRNE?=
 =?us-ascii?Q?q+up7078BAWM0N7BViwsZ7ZFXfrtnuafybKkTApb6X+bKKQPUYPuZs+n+I2R?=
 =?us-ascii?Q?hy9ND1QqjnzpPTu3JJ1cJW2wveUc1XBtlgXahWAeWx6Z4T5y57P0OjHY+XjD?=
 =?us-ascii?Q?KLRbZfEqgOzrf+66NfDbV1cFf0wYUOPV64XA6rcfANcA9sUTZ7aswQ50m23a?=
 =?us-ascii?Q?HL3J8BZxW43Ll0yMkVQuP/pO1ATxAacH392frteYPUlNjaM4wXXAdVRvQfw8?=
 =?us-ascii?Q?Dujm2YsTKk3H9ckYhY1zdTqQHMpeFrvs+1otf8ZY6Fs+t9+Y1TTEBE9YSV/j?=
 =?us-ascii?Q?7MYjrzgSlNWeT4H9CktQqCDHcyOcpdgVlAmcRlLJQwMOMoEa8jCmi0YEr1N+?=
 =?us-ascii?Q?nm/gPqbU212K6ShWEj1u10P6S/kZEjagJeAe/yXVY1Segz28Zya0akyH26Tm?=
 =?us-ascii?Q?iaOMqXFZDjU2oRE87hCwZrfwFOxHUHRON20ZfcfP771j3lEeRawzjBQmi753?=
 =?us-ascii?Q?wfiBZTaOxKFlpnCnh6/Hng5L1iLF5HXI3Av83CW0?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3432.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40672597-febb-48a1-f5dd-08dd49e97f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 15:42:17.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4ia0d01UmthP4/mrO9lMfUHV1/dmsBTgl6SGl0w8TZDfS28/D1lrXtXj0ekQk5yYDcoXTfickgVUKFAPsb0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2022



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Sunday, February 9, 2025 11:40 PM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Long Li <longli@microsoft.com>; Konstantin
> Taranov <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; Shradha Gupta <shradhagupta@microsoft.com>
> Subject: [PATCH v2 net-next 1/2] net: mana: Allow tso_max_size to go up-
> to GSO_MAX_SIZE
>=20
> Allow the max aggregated pkt size to go up-to GSO_MAX_SIZE for MANA NIC.
> This patch only increases the max allowable gso/gro pkt size for MANA
> devices and does not change the defaults.
> Following are the perf benefits by increasing the pkt aggregate size from
> legacy gso_max_size value(64K) to newer one(up-to 511K)
>=20
> for i in {1..10}; do netperf -t TCP_RR  -H 10.0.0.5 -p50000 -- -
> r80000,80000
> -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT|tail -1; done
>=20
> min	p90	p99	Throughput		gso_max_size
> 93	171	194	6594.25
> 97	154	180	7183.74
> 95	165	189	6927.86
> 96	165	188	6976.04
> 93	154	185	7338.05			64K
> 93	168	189	6938.03
> 94	169	189	6784.93
> 92	166	189	7117.56
> 94	179	191	6678.44
> 95	157	183	7277.81
>=20
> min	p90	p99	Throughput
> 93	134	146	8448.75
> 95	134	140	8396.54
> 94	137	148	8204.12
> 94	137	148	8244.41
> 94	128	139	8666.52			80K
> 94	141	153	8116.86
> 94	138	149	8163.92
> 92	135	142	8362.72
> 92	134	142	8497.57
> 93	136	148	8393.23
>=20
> Tested on azure env with Accelerated Networking enabled and disabled.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>



