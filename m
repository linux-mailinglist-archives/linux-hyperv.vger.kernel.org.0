Return-Path: <linux-hyperv+bounces-8358-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44DD3903D
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33C31300CA37
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEDA299950;
	Sat, 17 Jan 2026 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F9SItYNI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021087.outbound.protection.outlook.com [52.101.62.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56A1862A;
	Sat, 17 Jan 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672883; cv=fail; b=nQ7eSa7LTXW8XA4iSAZCG0loj9JJWmhfjPbCuYGEZFjiC525wgvF9uvS2+kwSWhEqy9BzADvTXA+EPRTVOX8dKs3pJ6lbXWGkWHhIkVuduUacUMN3zySJBFanpAjEe5uJy6wq/DkErhAaQOBepRE7N/oIZQDa7UKekg6hxFSWHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672883; c=relaxed/simple;
	bh=glp1/6CC9mS6giz5UP8Nketp5+DmO/V+WxRbrkqRsRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFUK9nkbiFbE82g2voY1AwZZng7tfJpOsStLRXsTUr3uZht0TK3I+Fq14Qb/jN7hVwar2cc9UKyJf21583U/z+qWvKtLvAtE0gORElzYr6jpZ7+oiFC/QLU5h0gSzzeSMPJ95gbUr8aZ8vGOCKI9g3ZXnI9LpnXfosMaUYyNvWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=F9SItYNI; arc=fail smtp.client-ip=52.101.62.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8+SHf58Y48UbVf8RDvNXe/oo3IX16uIpWGCmrO/Wv8cG6et6WHSZJHY++m0dc8/kPbRL5YyMz4W3iB4DB4mShRtWrxkqZv7qL4xHFO1l5doqjgeeFoEPkFJTTMIAKPTKMmI6ihwmPMxbGl81C//BBTrC9vRWWTFnA8cwtf2/z1KEpMwf89VKK7qB4MJ65qyDCoxuBn018nSznijVVQGVbqJHxP5OCRBxCUT57qr5DK9fubOTOlWPi7CdCQlfSHngBjXjBHgTDmrmQUQWJREH1HInIY28Cbhu68qctWlstxgN1WIGJVf65idB8wy6FRXDJEhH5qZyvH4bEDtUKGqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ybv6cdpHMDcewCan/9lOMp7A43w4F79jJ0cmA+tCuw=;
 b=n8KhFQ43VU5W49q/m86fgyl56ZWhZvE17tNydrebqkvWoXe22EKuE1PslRlMUS674jwOCw1EwW4wXhCr7b3vFG2eorYpjOCfU8Nui1dQNFIqqsvyr27lH/M5ehJcC9q+dX8BrPq5du50VoE+/G6R/GJY/yMVSo6EpLE359u9KW4Ch86Czgyn3UIcf0bAz6eS1X6wv196idPW8ZYbuvCHiv0nTGIKp3aQ++Bfs52lj2woPFkkhid0HUDO2Aj4DEw0X4Ng2IMBfb/Zon9eMBs0lB8RkPWpZUrDiwSV/TRGwVmPQ8o6/Unzksq01nB+NB817gr+9EH4M2SPGHSiqUtHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ybv6cdpHMDcewCan/9lOMp7A43w4F79jJ0cmA+tCuw=;
 b=F9SItYNIhwSqakByNUoVdT8RvzTaMztw7HS1JVxauvVz2F2j6sNrRx9uAi7DRbngki70XEHjTwqOgJOkqyaoqdZOgDOh4FbQpXmtrRqraiI+XJIlhdaqqFp5rjGHY8odJnBMO0OgwVcakNcMpgT3UFTt11+gug1IdadoTeP8DSw=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5744.namprd21.prod.outlook.com (2603:10b6:806:499::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Sat, 17 Jan
 2026 18:01:18 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9542.003; Sat, 17 Jan 2026
 18:01:18 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
Subject: RE: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Index:
 AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDAgAAFB6CAAKeVAIABIOnwgACOxQCAARoLgIAAbQoAgADxWmCAAZgKAIAABVQA
Date: Sat, 17 Jan 2026 18:01:18 +0000
Message-ID:
 <SA3PR21MB3867D18555258EDB7FCF9ACACA8AA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260114185450.58db5a6d@kernel.org>
	<SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260115181434.4494fe9f@kernel.org>
	<SA3PR21MB3867B98BBA96FF3BA7F42F3FCA8DA@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260117085850.0ece5765@kernel.org>
In-Reply-To: <20260117085850.0ece5765@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8750c673-d795-4df0-9dd8-7089ce0cfe1c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-17T17:17:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5744:EE_
x-ms-office365-filtering-correlation-id: b8b4b18f-7429-453a-c323-08de55f269ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?InXCnj6Pm2ZiIubC8O6lKe2xlsffx1BmCjkfwJWX4AFgptOmSlvm9GjfS/K7?=
 =?us-ascii?Q?HkLKaF3gfFlTf2WAFL30iWqvFaOQA+vKektiRS60jcyOHlYT/0seOnbrOM8E?=
 =?us-ascii?Q?cvARpxBS39iZ/xMJu5So/2MMOQWoBoYGQhJITJO/rd5MIXQ42mpkHjiq2Ibh?=
 =?us-ascii?Q?egy103FnOdFmOYXhsLSP6i3CmBC9t1duXE1tvumh60VEydCZJn9gEIVmTF3M?=
 =?us-ascii?Q?2zqw9YTHgTEJxtynFTEgN/SsYeshKwiBFaoIR+VXebtGrmXXL9Ynsf0FcNB5?=
 =?us-ascii?Q?PveD38qTUYrx4kMkLdcpeas8n72IXR9RzyjkROVXG6PTp1RtszFWdp6/zV49?=
 =?us-ascii?Q?WAUOe+LbM4SREWoshFcJZWV4aUVGppfX/Xa44vqp3xnKockplyROyjwW/hgs?=
 =?us-ascii?Q?2hNYu6cty57Gts/0Djc3Wznw54bPJE14E6aY14hhqWu+W46NeYt0UoSJ5S9V?=
 =?us-ascii?Q?aHkT2YcvKEtlSviO7TG3/4qAGVovuN64Kdqqu+klry1j6TJb8tjCd+FRLN+V?=
 =?us-ascii?Q?a1gMHVo7G/dfLxE1lSA18uAYTQR0Zvb2WePEm4ZHB8Lfwd9KtlJM93CQoDlv?=
 =?us-ascii?Q?gsbqOJG36EiCbjcevzY7vnMgV7BdoKrx5bbhSEqKj+zWlTHCdpC60gu7I5ET?=
 =?us-ascii?Q?L8Yhevba37ciY89phwaiRFjy3S8u9dcpE9a6msgMvDLlpJ5a5+2jqScTshPr?=
 =?us-ascii?Q?MlbxN6dydAdXt7HmmZMCodvoQA4yuUfDfcdzVQdxgz4kmt40kljtnukGAd3u?=
 =?us-ascii?Q?XRxYeCvra/CR630g9TSPQMROjwi2Qh0yJDMDTR8aeKiTylEnR6HguoB0y/7i?=
 =?us-ascii?Q?y4Spp9TWHgFSsYJMj7zLBP/rZwjXgLoe6eP7xviOiFMBAK6du2kuz7dyaF9d?=
 =?us-ascii?Q?3Y/CpNv9hx3B7E2Ggzt5Bbnu3OOBy45a89iGnY9/ujpDybfZliwEPixitHTL?=
 =?us-ascii?Q?DhnORvsT5KX8Rdlw3tjQDxTWWpb8/uApoqTKtQE24PMUH+i7OEFV8pI+xLOv?=
 =?us-ascii?Q?yqIBAva7FhJ6s6DX60+EnoU4NmxPUoYu2/InBMAsfgDWk64cKmUVaJF8NsuG?=
 =?us-ascii?Q?BeiTKZbdXQJj6pYm/gd8/CAtcZ4PA9JcH1U12BIjG5rQqdhd3AViqwbQntbk?=
 =?us-ascii?Q?jJ5fDD+cgH35gi7cova0E+2raCFCfWu6SuciO4BCZM+45zHejyv8kMP1TtGu?=
 =?us-ascii?Q?4kapNa39NYbnuf5D8OhPj+Knkn6IiwnVEiGsX/8x9k+p8zQaTtIQYk7bOSPM?=
 =?us-ascii?Q?bTnlFtI4ba7zVioLcfDpDNEu50bGsIQmzGe7Wrc4Ni1i3WnVjmL/699FJ7DR?=
 =?us-ascii?Q?XcQQChQxQ/ANFg/p2Ouck/Oykea1envOdbUeJqMda3lQTVhbklG2ACzA1i5b?=
 =?us-ascii?Q?1FwK+myndOIHZqrQR4JOgou/5La6ieToQXs8uP9AFI9vEVzZInDOIPHgA1lS?=
 =?us-ascii?Q?4q+bqk1iJQYW4SRZSpcxgjYoL8Gqh9XzNzrw3l3jyHl6eDEKUM2lzovUqsgm?=
 =?us-ascii?Q?Gx+YhuIikhnSLoFz9HQcTFMLKyn8C6HkSc+O22zXD0YZoB5wsr+W8XGGTPjx?=
 =?us-ascii?Q?AYCGn/sk+/ITr6slcjVjZZ8+kQUpxkUfBOLisGVo0yVtd1LjhkUjZ20Rw9ee?=
 =?us-ascii?Q?iNGPrJrccoG2BLoQEkuCw3g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?phBKKTpy4a0fc8QYWrUN5umdF32dRQbCrzff38bB12rU8XMgmZCRJJSKZTTn?=
 =?us-ascii?Q?BeNB1Sk3/ahOewUMBN1+3J/U/h1yNuyQHa8dpMDZKqvt0NAw8DL2jHxk5gqt?=
 =?us-ascii?Q?/vMEzHdPuIL086iPuSaI1eXGU2VzDvN/6N53wnZFbM+wwBNlKPXresX65JIS?=
 =?us-ascii?Q?KzSuQMy96oJcYV0hnuXz4BweVf8Lu3hffVpsQ+2j5TqfrNndEYjqLc9KwKXi?=
 =?us-ascii?Q?exTwTfCeeeA0keyFqvMgthzzcgbfb+14C28WVZPUquY7fSF9IWATb9NCikob?=
 =?us-ascii?Q?kU/8RVL4V6sYnQhrm1VriDsochVr3OH2zbBC6l58iw5cvVjsPyl/h/ZH9uyJ?=
 =?us-ascii?Q?u+QmJzadlVWoIYIMoxJajoMVwHpUGHiVWmZZuMgn28FCQHEjwEfFAqJhLFT9?=
 =?us-ascii?Q?8s76rA+bUk4Ejf327jeOKbWHelA7ZRKzgluP6Woe2ufv+IiIVYD8xwlzrp6l?=
 =?us-ascii?Q?LO+XV7snXv290MXcKC5JorKTutH4VVLUwmVZ9HXqjDhmVdZkMONlfexayuIH?=
 =?us-ascii?Q?qn2PX2oVrgC7dG7P6FVW6BKUfmH3ZAbEQlNH9VMkounQYTJRDVsJjc8o1xjT?=
 =?us-ascii?Q?RSv7FR5jLU9HSZBqlm/zVatjMX6uZ+WjBUlyqK8CUScARDU8Mi2MuYDsj+tr?=
 =?us-ascii?Q?613TPgxQr9ZymIeVlzBYWsWRwtywwKY9KHO4ksTTiBFeTuio0HFXYfB1+7WV?=
 =?us-ascii?Q?FtYfbsyZpvcz9U0hAMIfJNER/QaZGeEy1gLKqj/uzhDCbj+IdDvtqBXgTgwc?=
 =?us-ascii?Q?9B5sgPYMqbL3MyDXM/F1SVVrVqQ7PLhMe9FtnLmXh8Yl811z265Xe7Gk4wgF?=
 =?us-ascii?Q?L0q3FgoOIv8MGpRFV0wtkaLsS42DBShpznO9lXECEn+t8QkoFujENNqkPAR9?=
 =?us-ascii?Q?+5uuh8uufSZUcWeyERS5YIuUyNlLC4QJKLF1IKfXXjXlWR9thaGi9sMwVhhs?=
 =?us-ascii?Q?EQms4icX3r20AYdjrhGEdD2s1T+MDbD4P0Zz74YpRGAkMYexE4e+Hu1NN44U?=
 =?us-ascii?Q?MBumS9Ph5GYvVSKpsdwHg7Fx8+40mEt75VX/ZUSWfUewfhz/MMGL/9G6oCA9?=
 =?us-ascii?Q?emkDLGVSsdPKhaZVotdO9FEk4DOHIsH9ts/QIxGfgGxwJkQsp++isXIuexTj?=
 =?us-ascii?Q?7yQswhDe5r727/v5/dMFVGdSF5qTc9hpFDvkqrxG0zl7vA/e6AIItGikdrXc?=
 =?us-ascii?Q?toc4Wde+VgS6Zi6wEyP573zDG5fTMvYGN8ffIgjxdbZcy6bqIl2vNCKWsRsn?=
 =?us-ascii?Q?8FEyl7Y4a+LamvzXwRwIhWiKa1x4u+HdvO75RQ2FkiSbtey2WiiyCUin5+Qb?=
 =?us-ascii?Q?hvGn2lF4nikavHoC+eRLb/NJbMnFU4YiMx1QALJKrzF77Hy3BBhrwTotQWqx?=
 =?us-ascii?Q?OyvRaf484rG+S7WgzRX7h5xqatNzV0wfH4chG8LmQcQWA9y+Yl4Ww0Zy8yA4?=
 =?us-ascii?Q?n8sD4kL7yoM/jKdxJsEJh8zvD3U567Yv5UBoMtbqZNLpfe9SGFMGBZgMzZZg?=
 =?us-ascii?Q?KFiekvW802KlE9KzazQYeVngHH0KEiYXay8GD5AyXFfAyImbiXWfaJ5+ynN9?=
 =?us-ascii?Q?/MDaGsT031y3H/reBUdq/L9r8leEbSrx9ENlagbZNocbWrzpFVUnx483sHpB?=
 =?us-ascii?Q?AF/YskIRGwGIBKlsJqL6IlUTpDENES8CKs0fsYdmX0H6kHMsTP+WQDOp9U5/?=
 =?us-ascii?Q?nwqiOI0dR3oncB55lNWLeZuUgW0t1crQwCr/gosF1zFV9D5KWZ55NDdvzmXi?=
 =?us-ascii?Q?Ar+PmLe+GQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b4b18f-7429-453a-c323-08de55f269ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2026 18:01:18.0709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKJiISTpaYBeJYfR/ZjYPgGNRyA9H05M9F0ckB3D3fPfsdBgowX3SDGqcnWZShTaCR5Rf0Cepv15TX52C00Caw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5744



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, January 17, 2026 11:59 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Konstanti=
n
> Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>; Erni
> Sri Satya Vennela <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add
> support for coalesced RX packets on CQE
>=20
> On Fri, 16 Jan 2026 16:44:33 +0000 Haiyang Zhang wrote:
> > > You need to add a new param to the uAPI.
> >
> > Since this feature is not common to other NICs, can we use an
> > ethtool private flag instead?
>=20
> It's extremely common. Descriptor writeback at the granularity of one
> packet would kill PCIe performance. We just don't have uAPI so NICs
> either don't expose the knob or "reuse" another coalescing param.

I see. So how about adding a new param like below to "ethtool -C"?
ethtool -C|--coalesce devname [rx-cqe-coalesce on|off]


> > When the flag is set, the CQE coalescing will be enabled and put
> > up to 4 pkts in a CQE.
> >
> > > Please add both size and
> > > timeout. Expose the timeout as read only if your device doesn't
> support
> > > controlling it per queue.
> >
> > Does the "size" mean the max pks per CQE (1 or 4)?
>=20
> The definition of "size" is always a little funny when it comes to
> coalescing and ringparam. In Tx does one frame mean one wire frame
> or one TSO superframe? I wouldn't worry about the exact meaning of
> size too much. Important thing is that user knows what making this
> param smaller or larger will do.

In "ethtool -c" output, add a new value like this?
rx-cqe-frames:      (1 or 4 frames/CQE for this NIC)


> > The timeout value is not even exposed to driver, and subject to change
> > in the future. Also the HW mechanism is proprietary... So, can we not
> > "expose" the timeout value in "ethtool -c" outputs, because it's not
> > available at driver level?
>=20
> Add it to the FW API and have FW send the current value to the driver?

I don't know where is the timeout value in the HW / FW layers. Adding=20
new info to the HW/FW API needs other team's approval, and their work,=20
which will need a complex process and a long time.

> You were concerned (in the commit msg) that there's a latency cost,
> which is fair but I think for 99% of users 2usec is absolutely
> not detectable (it takes longer for the CPU to wake). So I think it'd
> be very valuable to the user to understand the order of magnitude of
> latency we're talking about here.

For now, may I document the 2us in the patch description? And add a
new item to the "ethtool -c" output, like "rx-cqe-usecs", label is as=20
"n/a" for now, while we work out with other teams on the time value=20
API at HW/FW layers? So, this CQE coalescing feature support won't be
blocked by this "2usec" info API for a long time?

Thanks,
- Haiyang


