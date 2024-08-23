Return-Path: <linux-hyperv+bounces-2829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BDE95D854
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EABB21BC0
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1F71C7B91;
	Fri, 23 Aug 2024 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GaqQM1JS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020134.outbound.protection.outlook.com [40.93.198.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF21953BA;
	Fri, 23 Aug 2024 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447548; cv=fail; b=dxKRYkdix7fG02KgMXAwT2cj+9DaNIGwrQHDPmIC9fgJEABcI/RiUwQx4bk/t7UWaaQ86cNjsu9wTnNS+2eIbbnyzfe745FN4rfSRleuAJPxBG60efiTACuaxnbH6vMEmkDz5Dig6hRXHaUEcUpyKlsqK2ryJpoo6nLvlUqifoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447548; c=relaxed/simple;
	bh=8wtY698yKJVaByIWmO9AHwoujXw5ZUaMoYAxVz2CRqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DckXaTVqNIWCLLf72OJc1fAaKm/4IDaCZlz31mMk9V/88+26jrpEQVa+Ysru18iNAWKeCi0BE020KVD7BHZT8EaMGql+3nfZ5qtTFm2Ha3+XxSCxyrRQGSldAwgtgogpam8x25dy4Sn0P4yZ9cwogN92tGmp5Vxz2HL8owkKhfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GaqQM1JS; arc=fail smtp.client-ip=40.93.198.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ureHpyWD4Zoak4dOQbzhi93BvKkPQUZwwHjDj2mgmZwc9hMdqH3hTzF0vqMEfRzoXJbWiMOeRI22N7R51hkocekrx9m21G2DhQsvVUM3g4GN4G3IgLpRkrrKaFlnnsLFlDFg8H8c+GYQY6MA1bFZrL27csvrX3omJuA/lU+MeLNrVGNzzOghIUarlDzSMeJrYIr2jcwRhrkNHJbeZYb0Czvp3qLTzGbnk9/UuCKnvNl0Ksg3ipZp8JohO/A3FrG8zymGMPK2yasohYnd0XuBabirnXX1aAB3Z8Hqfyr4O4IWywEpvCyLSmYycfMYGDwx3fKf+1w8W5h4fBuTVL+jNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx8ct2Abh91aez0GZkvnhEB+S4ht3psAFQot5CANKsY=;
 b=cvtKshV8uUNGO+GS9p2NK+RCp3QatWVP5kaoi9YJp4tFyv9Wxfie0sJ6xcEdoKZhDmyN/bKYnLZ8Y+TqpdKTmKb+iY6NP8RJpi0X6dXsXFFDpwv87fKlhftEC62767IsrMmNuRZTBJVbcve5/Lvuoro0t2caAXXaNXZoRUJ+6+5CN7bIP62C8nXOT+CPbpat6xPav9V4q9kPvd1ZWNBF67rWnjYqY5+swQTOq0SBQBX+lsVdaZWgIdlkhElFEt2V81ch8R6OefCCGjiVI5Vvg705dxxWHASWYq3sfbUddAPou3gT223lp0Ruf8/DyBGDIYZSpZDTVqH/KpmVCdXDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx8ct2Abh91aez0GZkvnhEB+S4ht3psAFQot5CANKsY=;
 b=GaqQM1JSyQqw1Y5sfqXbLbOvCVjxi28z9BAEs9VD+mwEKge4MVMbnOib2PQf7Pg3VrAgrVlFIaX8nZK3vPb+XazUNcOlj81XvzToX4PbidQp0wkWXPo0wAH08RMFHKHbMph9XGjJ/1yNW6ETFlNIwFUynd6tpxx4w2U8UCA/AqA=
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::14e) by DM6PR21MB1417.namprd21.prod.outlook.com
 (2603:10b6:5:254::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.9; Fri, 23 Aug
 2024 21:12:23 +0000
Received: from CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::96f:119a:a52d:9f87]) by CH2PPF910B3338D.namprd21.prod.outlook.com
 ([fe80::96f:119a:a52d:9f87%8]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 21:12:23 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"leon@kernel.org" <leon@kernel.org>, "cai.huoqing@linux.dev"
	<cai.huoqing@linux.dev>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH V2 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Thread-Topic: [PATCH V2 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Thread-Index: AQHa9UEVELhGtfD9eEKKrtt//X0z5bI1VxaQ
Date: Fri, 23 Aug 2024 21:12:23 +0000
Message-ID:
 <CH2PPF910B3338DF57021943FF5799FCC75CA882@CH2PPF910B3338D.namprd21.prod.outlook.com>
References:
 <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=78f98c37-42b0-4c58-94de-92514b75fc80;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-23T21:09:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF910B3338D:EE_|DM6PR21MB1417:EE_
x-ms-office365-filtering-correlation-id: 40d4d0ab-5b86-413e-3854-08dcc3b84881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZrxRyK/a4TRTgKMmmSDtzqyqIiFwfFY+ucIyZAxS0PvrUCaW7BmifGv6qSIa?=
 =?us-ascii?Q?yXDAEO+LAd+VtU7Wd2cuW4Ss7uwsOAIbsBHKWiX3mBoYjbrzoY3xAp9g5VbJ?=
 =?us-ascii?Q?LUoIf6E6d8Zm4JBMkRfh4N0RSfl1WNthL7XAsN83N/IBst0Wttu6OHWQEFU1?=
 =?us-ascii?Q?4T2Ez4/z+sks11heGtbtc16BUGY1gINmX5lVhwzA/h/jiWw2ooeZVRqtTa3k?=
 =?us-ascii?Q?imcP/GNXU75EcvubIt2b1BABrmqbraHW40gN1L+UMS/+KNVQJ0dr16SCeRnM?=
 =?us-ascii?Q?LrmmICCPtMCj1RMHHHiAlVSL8zpaqcbdtiH/3me4oRBubuwwaRSZS9RdzjyL?=
 =?us-ascii?Q?w+SNvnFMe2nuFjh6NGRm0pkqTqgcvRvqtg1dQ7E5gfIVWmGC0duYu29NOgGr?=
 =?us-ascii?Q?2a6X5AEi1oW+I6HC1eoXTlquYzoqKGoK+P5oOrqj60CQsLRixhshGG/StmjA?=
 =?us-ascii?Q?ADoreACOvsGBderNRz5002rT2ZWqTdFEmvcC4jBAixUzJOKTFhV8sFDBytAk?=
 =?us-ascii?Q?ZmK4reHigWwJ26NQ2cjgd9nY2hm1nmOZNYHnMqcawFkvZPG3UDKLf2oIDgO1?=
 =?us-ascii?Q?Tcz1Zks98WlwqlKPAWrUuPd/LRqwArjvOMoiECdQKKGrXGF4Ztb4kHNu1GnU?=
 =?us-ascii?Q?fASlGzG69t2tYX8/FBV3/UZKPSOY4e+CvbzGM+su7rkpYnDXWGPGsMoe8mKk?=
 =?us-ascii?Q?JeWQI6/X9iCcJIpJA8cfMZyCW93u40V6IOb+DZ4PKjwvhoLgZ385zffrE97n?=
 =?us-ascii?Q?lWeUyG8iio+XybdQi73MBONOaWSGrwHIjOsSwGMKEjvUfr6tbWRFzyoO/EBg?=
 =?us-ascii?Q?llhxzlbFa4nd2m2utcxESgw0kj55NHQg0VKWo7GietOTGI054u6v0fUWLfu/?=
 =?us-ascii?Q?RzDIPkq+a3ZYGh7AQ8XRH8HPuG636V5dZJXGHj09Lc+f/Yq1lGxMDi+3Ns7J?=
 =?us-ascii?Q?nnAheXE0ygp5x5MZLu2b7MwMhY2I4IlClK05eQfEH2Fv+f/qbhgduGJ6RV4Y?=
 =?us-ascii?Q?ZAZRR/zuUBY3xEPo/CGd1gzXu1+f2recasS4VT/UXmqLiVOtV6UdTUsdzpnl?=
 =?us-ascii?Q?Ct+kmxoH/B79/mEY/Lfw7iXDt+/lM/3hpFKWzvu8FE7Z75uL/w5n9FzqNPum?=
 =?us-ascii?Q?3349npaRCZxtpbVTe8xpq+ug6MTjzljYO3xjoN8zqk8scqNhBOcFcGKvBx1+?=
 =?us-ascii?Q?K7sk2IQnco7soqNuaMHCTNfHqm425IC82YgT1yEDhEvSLffoBqCwczuMD3ik?=
 =?us-ascii?Q?DTSMQ64mofMs4I8kVqBkIWzkiQi9Z6xHOBE02bt4YUGrGXedTRQw/Ns8d1vv?=
 =?us-ascii?Q?qwA0OnSw/duIvozvvcL8NuZIBq6526opXW4uWfWj7z7+Hf8m/jOTqpuU6Z16?=
 =?us-ascii?Q?8q+q0r/uf9vdOLMMW/COH05/Cj0lhHcXsE02UajcHePp4rJrhv5k985iUCvw?=
 =?us-ascii?Q?xofW9e7/3YA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF910B3338D.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Le9PYH6HDOaP5CD1LUXGaux7V/+SLg5Kiwh1W+rIjvCFh+iNWUNHPo/QNVjN?=
 =?us-ascii?Q?qUo3/vN/qTJJkz2iwmPQe4GtMQJpJM0hy6BlYhs9yGOcjj7IodZM5cqJ/d0e?=
 =?us-ascii?Q?am/A9iZhYVnigGy1ymQ+VN6BcV0mu/NW8ZAfiaGfJz4ZQoNerpSmBMeKKY6G?=
 =?us-ascii?Q?AbLSP+UsY5QpPGClc4B0H+8tpL38c7NFjtIp84nPQErnWJgK/vC+yc0CCWgN?=
 =?us-ascii?Q?TM1Y36tkyiizJXC6OgdRgMTyMkaAvIM8JX2d/JsmAqN/HgPzZU6b9N7JuqB6?=
 =?us-ascii?Q?rUp9qTr+M5fFu7scLXKu4DsU0Vvd1eeqNXlUveDLBwTMSof86Cc2/EHNf7cI?=
 =?us-ascii?Q?oNL/+8wRqWudhTsdaVszVCIssIbtkezPAVy/NVB/hZHB4wiIYPQXncJirtjl?=
 =?us-ascii?Q?+BIuT6y9/S2kL0pHgp75/QJOrBxwIBNkbbtJoCPlhd8A2J3J8hrzSz6FDLDF?=
 =?us-ascii?Q?0ui8FLtQT99BtSBFlNYjqIUtz5d7HvtWxKSU+XBcVK8nK5eQJcZO8pR3LVbU?=
 =?us-ascii?Q?+lFlqQefTDn5cOkPNnVXB5ajkXpDxXrs6hcZt6U1ZPtxLpFD4JJSYKeKgsWo?=
 =?us-ascii?Q?kU7uYtiiy+zVZTsMBILhQMjazN00hfX/bvl88i7CEeLmCfRaksRq9nO8dRg4?=
 =?us-ascii?Q?vkcNyIK/9aqvS2aNG4lsNC5M6RQtKSD6RocXkcU5fp6jeywGsoZwMX0Dgfgs?=
 =?us-ascii?Q?C7lZP2VHqE1AxouMNeVUyqYuAzoJYPqyiRDhnJHl4Pi4VclA89udJF4ETmHo?=
 =?us-ascii?Q?0nThrC+8pUZjFZx3cHTx0CJdt51bh/W60+GbVXpKG/arQmhwXMAeaI/tlq6P?=
 =?us-ascii?Q?9QtZvca5HETq/W2E/Rv6hR4wsl2u2OONLzV9kGIZkQo77WArvhTkYNyytGDu?=
 =?us-ascii?Q?4ZMJsA554HNgIF0DF1cqCOv6jAIKM4WtJWqUDOZBYYnlKe+VbKFwls2J5kFv?=
 =?us-ascii?Q?R7n04QgV2S7yTtAZFCJntqP/YhNQosKmag66KPd6SnON2j8nWC249QCfxpRf?=
 =?us-ascii?Q?D3q2b+D4NcxCvvdXfrDDaQ01lbdCrBxaoyOWhvaPXIPIhsQ73G2zusDzN6WY?=
 =?us-ascii?Q?/81W1QMLbnqXRFYjsYNd0HJD1t8HqntIzsPqT/6QNgghvTBVtXlMzFIa1czL?=
 =?us-ascii?Q?4sSw5POc1n+ouEOwonX5xinZpcuWa0sVO08dzSq159qC9YupRtsMWC1q89oS?=
 =?us-ascii?Q?jINCEviEwgwtOJIPwXQANSz0Tk8qyiDO6P0li7LqotyvtK7y7EYDjRm5uB5j?=
 =?us-ascii?Q?lgAd+dqTPez29L8/xNsjSdCe/OShbA5BCjYT0nUQ4goulMrGjvZBszS7hanC?=
 =?us-ascii?Q?AffA6h+Hkp6odiI2xn8XXQGGGUOKVzob4jDTIIGmtg86SyP8U7BQ8BqwHlns?=
 =?us-ascii?Q?BAilWW2oDvuftnkUgM/vFHJaLEgoBTfFx4u9xcC/3FP5oDetq1skp5egLK9A?=
 =?us-ascii?Q?+FJIpqt2iG6naLUxfTlSWI54WU38eDN6Dex87MD5n/0G48TpYch0pdQ/0Yxp?=
 =?us-ascii?Q?TF6+zS/kSKNSAaWuMIM/5kEAOMXlfGCREifLtf0bAaIZOISWhk93NoiWd2Oe?=
 =?us-ascii?Q?nUyYS3QWK6BS/pXZU1qGmOYicBgkxcUN0OEd6bom?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF910B3338D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d4d0ab-5b86-413e-3854-08dcc3b84881
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 21:12:23.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTWAo4/Upo4p7qefhckFNGNAy4lzfyCLdXJK2i4bEKbMPueDbjq7clQhfeKQYOCH+nGoADYAqr44O0vA3Dh/CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1417



> -----Original Message-----
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Friday, August 23, 2024 5:44 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> yury.norov@gmail.com; leon@kernel.org; cai.huoqing@linux.dev;
> ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Souradeep
> Chakrabarti <schakrabarti@linux.microsoft.com>
> Subject: [PATCH V2 net] net: mana: Fix error handling in
> mana_create_txq/rxq's NAPI cleanup
>=20
> Currently napi_disable() gets called during rxq and txq cleanup,
> even before napi is enabled and hrtimer is initialized. It causes
> kernel panic.
>=20
> ? page_fault_oops+0x136/0x2b0
>   ? page_counter_cancel+0x2e/0x80
>   ? do_user_addr_fault+0x2f2/0x640
>   ? refill_obj_stock+0xc4/0x110
>   ? exc_page_fault+0x71/0x160
>   ? asm_exc_page_fault+0x27/0x30
>   ? __mmdrop+0x10/0x180
>   ? __mmdrop+0xec/0x180
>   ? hrtimer_active+0xd/0x50
>   hrtimer_try_to_cancel+0x2c/0xf0
>   hrtimer_cancel+0x15/0x30
>   napi_disable+0x65/0x90
>   mana_destroy_rxq+0x4c/0x2f0
>   mana_create_rxq.isra.0+0x56c/0x6d0
>   ? mana_uncfg_vport+0x50/0x50
>   mana_alloc_queues+0x21b/0x320
>   ? skb_dequeue+0x5f/0x80
>=20
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Please add:
Cc: stable@vger.kernel.org

Thanks.

