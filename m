Return-Path: <linux-hyperv+bounces-2149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58958C7AA9
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 18:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2257FB223D0
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB14C63;
	Thu, 16 May 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hD6Ladks"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6AD1DA3A;
	Thu, 16 May 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878062; cv=fail; b=Xk3x/DSp4aUe2O1TRs5E2qlWVbhIoknlwoszAUFkCXEXJ4U/uqCE1h+pQWvdn8Dviweef0432xz77azFF7DD7TsjpgTlwB+B7pfd8j6qXh43FFzHPTfSbzyvGYgPrUFiS234QQXl+2Wsoh7SaLHm9WqaEc/63MN985D75qQe8Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878062; c=relaxed/simple;
	bh=/FWnMbtNyIEUXCVgrPMFp9QelWFS6OEC4vfiQC1/R8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UB/noMCk0zh4ihsubOkPgZufe8bgouwNfJFa0yjf7BQ+dxHXvUjFY9Qqbiegem2mwKHoIIDOFLBBzC8PI8rifGppzcpM9Ke5t2QZht+ufoTA4ksIsC5hkcuuCp1HAw7YNMjUdM0MiR1M3DzYkRn3453G16WctCVOvZf1/EsNKZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hD6Ladks; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJmE1D9g1tXnmUj/0xz3Sr7Kv6RA46fB8ZbwkMU2PoHmDmtuEy8bai8U2F7vSsRJInJWCwG5h1JKEre1Z6Gi6Kltwu6762WadbgsFWzZGp8TCE/oZKtFFmcq/OROORrL2HPaOEJgyAyYRR7cJ5V9pz0ApdkStsSsNsRH8qxSS4K7ZSoeb1Q9aaaz1TBAN+1CIGXVLwkY1ipN+t3Rn11GRf51ek7b0EWanVDoQm+88F9Ib4mFcWqaICib24H7E11g4n+6cOQBVHb7KY4scMxYbHBt7jqPNJcyd6wnevJvM+6C6LJWYwmoryX4wQVY0loCiBE2WBItNiwd/qXTZFEgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FWnMbtNyIEUXCVgrPMFp9QelWFS6OEC4vfiQC1/R8A=;
 b=k+E82iRsEAB1DYEirpQyb0gCT3WnPPWzZkEBb287/rq9eUR9TPAqwtXGYS6RZ/Y+2nZf3jX7VeYQ2jtcBD1A4sblYqrTF0JYYOMOPCM6VAS7AMquRcEgnrbe4DCSPA6tdEWOxHVbA0vCDUs4bglg6G+GsfFXAkAOxClZbtWmU7v4LH/2z+NM4KkU6nPDQ5zFq6uyS+OQLo7yCmCF83AA8Su9oH2BlBpCyqtdG+UdIoIu8vli/atMUaC/SzVPaqhSzADvBtP1jpSzr8YGP46sWFiu3STmlQXcKeSk24HL+DdXEwjp2AByhE1lF/K8BFpQCEVPGOXveQPsyM4xDn8WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FWnMbtNyIEUXCVgrPMFp9QelWFS6OEC4vfiQC1/R8A=;
 b=hD6LadksbyCHRA06GYd889jcVTb99kx4RBEyHnxC/UgmAr7iHZUjO0pITdqfIudhO1qwJtKQVWIFKNtp3va1G6o8d6lufzGuO9iJi8Bwz4LmdvVyzSvK+voA9obaRFZw2rmbaICjiosSjYQE4KJDODU1O49h/7ioaxo+Sx6yLq4=
Received: from MWHPR21MB4524.namprd21.prod.outlook.com (2603:10b6:303:280::21)
 by SJ1PR21MB3746.namprd21.prod.outlook.com (2603:10b6:a03:452::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10; Thu, 16 May
 2024 16:47:36 +0000
Received: from MWHPR21MB4524.namprd21.prod.outlook.com
 ([fe80::902a:9fe4:fca3:2cef]) by MWHPR21MB4524.namprd21.prod.outlook.com
 ([fe80::902a:9fe4:fca3:2cef%4]) with mapi id 15.20.7611.010; Thu, 16 May 2024
 16:47:36 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "yury.norov@gmail.com"
	<yury.norov@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, vkuznets
	<vkuznets@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Fix the extra HZ in mana_hwc_send_request
Thread-Topic: [PATCH] net: mana: Fix the extra HZ in mana_hwc_send_request
Thread-Index: AQHap6sasP156/E7HUu0miTrMF3QqrGaEeVg
Date: Thu, 16 May 2024 16:47:36 +0000
Message-ID:
 <MWHPR21MB4524DB41192F9C540D322A1ABFED2@MWHPR21MB4524.namprd21.prod.outlook.com>
References:
 <1715875538-21499-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1715875538-21499-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1de2efad-6a85-4880-ae18-babc494e9a60;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-16T16:46:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR21MB4524:EE_|SJ1PR21MB3746:EE_
x-ms-office365-filtering-correlation-id: fb2749ad-c857-47b4-bf96-08dc75c7e405
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?twXFGANpt/+IpSX2kM2KVDfMqgpzaqLCF0n+kDK+5BRcvSbLwNQZERncHSF2?=
 =?us-ascii?Q?AYN9B9Ten3WFDBoOqyjxHMP2dRUZCOjvSiHpB2cVqNJ/L33DnyqxEt5S3dA5?=
 =?us-ascii?Q?IsKRnghpCpszwHcsG6oI7eg2zwiMo3MCHBeuV48+Vq756RZLal1EVJ3CMdTZ?=
 =?us-ascii?Q?llB5MbHhnhSI/NB3Jg+xrDHKiUkwcp+380yDcfHmorOqBIYZL26uciHPPEll?=
 =?us-ascii?Q?OxjrBiSvA0GF9iMCija/5l52nWh71HrHVF8rlDgGLcHqWFN4/r3+/CEFkNPe?=
 =?us-ascii?Q?AqaTFj8ZHvubm71562pyjPrjHP/+0tj9wB02olBV/ZSY3EnGzSavYQB4kdgW?=
 =?us-ascii?Q?LOHy4DErP6DpCurRNejFxNvY3BxWT2dZNcRgJSG9sY8dWZdI7rZwLRx2KDg+?=
 =?us-ascii?Q?n+Zgc9JzGmnDINLfdGGZqL2VNhY5Z8KS5/L9y2glPNV+g116EYtgurYMnMW7?=
 =?us-ascii?Q?sKB9H89BF9j7KqzPsXcjyA5a3yGvzgheF6CgDvGr4ZJI315HXSpi5PSx4Yob?=
 =?us-ascii?Q?s5A+Gnl7ykyGoC2yzCv/sUzj90dNgwGSztIvvaH+2VXSu198h013uEVrPvAY?=
 =?us-ascii?Q?+ZOYq8YP5hrYaNlU/m0lqAwEPea7bekt9KZQ0A864VkXvY8BbeNwf3N64L0o?=
 =?us-ascii?Q?93lr7otI4EzxkhWhqinXr/rHoTpwtKKikCQp5xPupW+xksSpSBa577uRbYdY?=
 =?us-ascii?Q?iVkpiB+9UJo7xDV34mRnhhCQXyxqsBRXf+d054OGtjlkmTFFnM7HIUpH0rdq?=
 =?us-ascii?Q?0D8ggQL39c/qhEJ6ZmVppkuo750mDkOHINywJu3hhdB2aMSYnVboDdL26Y2j?=
 =?us-ascii?Q?NcijCrKkRP2aRZbHxR4itJgI/BN8jYd5lVUiibHbNk1pxqVpzs+XAI/1c4uE?=
 =?us-ascii?Q?5zKsS8zPkGCBk62/5ODDFcfJOI7q7uu+4y9BRH7SyK7R//wphi1p+0bkMWFz?=
 =?us-ascii?Q?4PdrxpE9CJ36kbkJ8lFVtGwkKMaxB71CUUOVzDbguBAOe7tnlj+/A3XObLhr?=
 =?us-ascii?Q?1gPev47BchcDNV9YadipCRA3OQXMDvm4OXqlmlm9n4Szy8XXB1c5EX3GSvzv?=
 =?us-ascii?Q?1/b5Km2Y4se61/ptZD8i1RcSH/LlI0t7uTCuKV73w61jM4wCdOJJfS81vGjB?=
 =?us-ascii?Q?kr1hF/FzyUltTIrzM2USnee/++54Hitr1XTeh1j1Ls4OHeZz/NXald1DtVLk?=
 =?us-ascii?Q?ukUkY+15ggugiMUZcNQLxmjLbhaczLbTCd5nl6A3GkroOlT1FDPXSFe0UBoV?=
 =?us-ascii?Q?V93GSfdU+gOKsz2ar+WaPZmr2+sjkZ+rRC0sTJDdYNBG9/JUrH0aQdx7PWo0?=
 =?us-ascii?Q?HWa6G2FwANFOKrtj9NCpFkuH/7e3hMwljwBlex7Ig2vAKZ+31Bw+d+orZUi/?=
 =?us-ascii?Q?+pEtWH0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB4524.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CJZpC/D2kV3czbu9fvO3+a85Yq2+M42v+NrL3KYr3R0i6RNSy0xLbfU4Uv4d?=
 =?us-ascii?Q?eVOXpIlUft1RTEat68svj5y7Hxda5TB2NPhyRJZ+3LWvzssfpJVMnRSCAGQb?=
 =?us-ascii?Q?l7l4zOBAOiFpadpN0OW+T7fCrdj2Q6rU8CvcteCydSdLyqFt6FFqlVAOxgE3?=
 =?us-ascii?Q?+If3g9vHBQKY8R5dEZQtX9PpXRy04sVRHa+g83Rp5b55ZXAD1haRmXQYwTeb?=
 =?us-ascii?Q?gunpO5+CcvCuIGq3DyHtST4S7M9PjggsrgafYKHrWZMXL/Xf4EkWC9O27JJS?=
 =?us-ascii?Q?1fJqWM7bU5SCQoRml27pN/3/tQJF5JPR+gngtx+vNyu58s/kJmv46gXq8xCV?=
 =?us-ascii?Q?2/RosFPyedZcdX27foZKvbnxUgpUbjM0fNsp2ihSVfr9kmC1Im6JCGEdAO/L?=
 =?us-ascii?Q?BpeAZt4eJMR9CpiaWdQZtbg0enWEZ64Ck6n538Six9VXEO7XIV72n9AijcW3?=
 =?us-ascii?Q?ywjWVK03paSH6OA1pa6MIRwSz0aSjHkTppmkWscIhNX2QPIrz6yFInydL/q0?=
 =?us-ascii?Q?pz+V12aeFQP7SAhZxkaQfepe6CukSV0yjDPP5PBvhNWWtEnWO3WHb40Icyf0?=
 =?us-ascii?Q?skUabn2wsoe0FVgYld5APs0TEPlc2/RuA1C45IJ1zzvou9g8D89k+wtZh2o+?=
 =?us-ascii?Q?AYbdeqL5ecTiFLRZ53NS1nBa3CGx4Pb+w6/OEf2SuP/hLlDcly/CM+EVt85Y?=
 =?us-ascii?Q?Qd6EhuarY4Ydvw5r6Orp9GKU/3/l8eYoOTp2qpvfJ2M5mfcdpX0WaCyNBPgx?=
 =?us-ascii?Q?IT+R2yfGSG3ZTeGKVl8jC4rFYMdAKp9y4rGCemm+l95BAJ/SqDKydsB40p+x?=
 =?us-ascii?Q?x8o5dyFEGr3t3GyeMHGd2BlMUsSc4sICa2edGNjHDvnVuWT5LKUl1rUFwzpk?=
 =?us-ascii?Q?HFOaHyNYn8RCpdmJJmaOm72nVP4NP4KOsV9GZmq2ZrN5vsBv0mRMFy4SNF6u?=
 =?us-ascii?Q?GUGUBk0wbvREATd4u88ai7pQ2cup+9YDCtboI+mjUK0YQ7sggRJmX1ag4+62?=
 =?us-ascii?Q?wFr3ELxAcrFu8demq6ckYd1k6cel0tp5xktg1S8it9+WZejXHBPXuAYFUg9x?=
 =?us-ascii?Q?9u5PwJA32xxHBIV5s12l35ECF4iFkE2qtuKKYDVQK/SiAxzU/wS3FzuYyYGv?=
 =?us-ascii?Q?WfunuJ85lxo7HFNDEHtIrBXsQtA+8/cODuzFFrkB2LtOE25Luto+gtoaYjox?=
 =?us-ascii?Q?2VPjSARjXrUTSi+uVPnSd1Ov84z3fKERhnM/NYcrT1cNWxBMH/RfQuLnIhQh?=
 =?us-ascii?Q?RakSfb37rO04Z8mwEiZWuQNw/Su/ryCKmI9Pr7oinqRg7QiBAKfS8ffTiQRz?=
 =?us-ascii?Q?8KNLXO/YPesxsyvEfYQN+hs0QmJNRUkl8QbOoWg7jg0aY4vfNr0UTdamAKw1?=
 =?us-ascii?Q?ABNHPLB1PHjEfXfztIXpriw8MbRIH3dr0smNTNu2NSd1yVBejZhC3eRXG9r1?=
 =?us-ascii?Q?xoz+56X6xCSTggf2/5igAD7DbR8/KaSrkvaHF4nJIjOCMzzME83bF1wY5DXR?=
 =?us-ascii?Q?b8bQeU2Zyt6IFp+9eWnTXKysT1q3KBASBJNeqTAVBs+3VlrwW4mO5qt9mVhk?=
 =?us-ascii?Q?m7jdILCw+ZVV/r7gt5E=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB4524.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2749ad-c857-47b4-bf96-08dc75c7e405
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 16:47:36.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /B4qzkhVCkt125oglQNL5l0B8+TAHdYoqnTE2FVC1iph+9xBT9qQTy1ylOxHeHfQk8cIdKimqLRu//06PX4rqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3746

> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Thursday, May 16, 2024 9:06 AM
> ...
> Commit 62c1bff593b7 added an extra HZ along with msecs_to_jiffies.
> This patch fixes that.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 62c1bff593b7 ("net: mana: Configure hwc timeout from hardware")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
Looks good to me.
Reviewed-by: Dexuan Cui <decui@microsoft.com>

