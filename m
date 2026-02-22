Return-Path: <linux-hyperv+bounces-8940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOIQHg12m2mCzwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8940-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Feb 2026 22:33:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC54170708
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Feb 2026 22:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F4F330091E6
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Feb 2026 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479B1EB9F2;
	Sun, 22 Feb 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SazM4cku"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022096.outbound.protection.outlook.com [40.107.200.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39617BB21;
	Sun, 22 Feb 2026 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795975; cv=fail; b=QVMfEiujn5P0SUuoOAyO5vhmQyFd9EbPpMA2lQdu6DELLICXpHV9ht3kCkSJa51XHAp7P0thmuc3HG8BU+S5FbCuc4nQG9lrOku2kD4c91vfNk8dmSi1Sl3ulZie1tG2WBClJwtJb1j1mJlBt7rBF6NZrFde22q4B/RArmxFHL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795975; c=relaxed/simple;
	bh=Adfvem5IBNDOsrgAy15fTZCPe+SVvvTycT3K37JVkdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0rH43HosBTnigViy7qqdkmVsLkU01VHR97eJZd7RYTZsAd4wZhD0GuEBDyan3gjx18WaB1ha9fiBWc3rPGqBX6zK7Yl3/m7h53RseIixGrwKeTmSkv3oI2YLHTI0oRGMmpS2wdHV8736tqy1iU7zAY8KyDdZWApJMl05FTzhaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SazM4cku; arc=fail smtp.client-ip=40.107.200.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS/0kxUQmWLGg9LEVGgtG4KG9klJIdpjSaLLhEFxmUoNC/UY9UzV+nJPwpNA8FSwCPwKugmN78OIJTM0leWoOwlk8/AckGfvwFvZWr5EjX3QLG3xzjukIIMinTayLEGBxu0mVUcr02eejCq4OrxDvsRCPWg3S2R+RpLfkZ7bJltdhtu2KQcqu3VwTFsZt2LLwjMwtkQNFg7hbbCIiOvQHQI9QnIxofUenoRnBkEjqYi20/AUdIDqCaLrRJovJ8UKwDWEUUm2zhaVUTc52KIwZAku0x6g2K5zF0GDgsmPtTVdvXz4o8fcjqynWRdAcWh7AaNTw+u3r7qsZkqw0EwStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5nwQuE7Ts2vW3Bxcyvqz54TtlZ31u1d2yrC5B5EQEU=;
 b=DfGf7q2i3A12gf4oBDAld0k9naL2J3/H/sEUSoFOs7MD9xX85LEdBwUwhSxGHUwERP6Ugs0wIJl/txjzLti60mDdFejRmku7DdRWyqboenMKBN/bk4VuTc5QaHmhh2RSs8tG2T/o25n07Ch2ng3Z+oeIXjMH2aglm6ryBdbqaTmf0bDsB5FI2+ak0CVo7xkstEXPZWtFR97JKhUd8RQ+DSB/9UZKg8weUgN69H5+Q2KoYJtomHJ3arqs/UOS0QMvj+zKjlNpNWJs4m4fh4xFCHDT9sqcyOT6Vyy7iLJX9jN3FvBRxEwENj4xo40ny7bg96T/w1GcoMWMh1sSr93IlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5nwQuE7Ts2vW3Bxcyvqz54TtlZ31u1d2yrC5B5EQEU=;
 b=SazM4ckug5i7O/NuKDk6DvVYk4gDG0lPmvt4AHucJxaRi4f2zDS40LgeRI2s3Sk+8af+NV3DessK9q2NULLpBsr3GQa0t0wEmDt5lYysrOf5YAKPWTW59lspMrrEsvi7snqg225nmCeHqhOps39AS0tBB7CeZCqTU/QRoX1K9i0=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6873.namprd21.prod.outlook.com (2603:10b6:806:4a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.6; Sun, 22 Feb
 2026 21:32:50 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9632.010; Sun, 22 Feb 2026
 21:32:50 +0000
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
 AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDAgAAFB6CAAKeVAIABIOnwgACOxQCAARoLgIAAbQoAgADxWmCAAZgKAIAABVQAgABccoCAOH03kA==
Date: Sun, 22 Feb 2026 21:32:50 +0000
Message-ID:
 <SA3PR21MB3867A6288D9B8F6FEBE56C1BCA76A@SA3PR21MB3867.namprd21.prod.outlook.com>
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
	<SA3PR21MB3867D18555258EDB7FCF9ACACA8AA@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260117144847.20676729@kernel.org>
In-Reply-To: <20260117144847.20676729@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ad950329-950f-4434-854c-2c5aeb380288;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-22T21:27:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6873:EE_
x-ms-office365-filtering-correlation-id: f755cc6b-a5ae-433a-6177-08de7259ee2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TG4GOO6YxiufigSwuuAJYdKZDMpopKWNfUl0SyUUPPC0cTAxiMl26tjVPFGF?=
 =?us-ascii?Q?EL/BFsXe5U1394OkRdYCnYeInNe3i9sZfQvFPVlygrG5U4Udud0EatvE+3g1?=
 =?us-ascii?Q?vcvCGNgZIEz+lCuchXhw5pFtgUGUWVU3UGwgcIiQ+2Q7bVU8CwptxJV+xCUB?=
 =?us-ascii?Q?k0Z6lkGvYMDsf8y8gsJ2oPV0wm00A329gnXRr+QPQY/NuVG8OqcFdNeM+lwg?=
 =?us-ascii?Q?v+U5mjUiQDpW+Me0+TTmgGbHXloTeP7yHBa5w93bHn4bl1pv8s5cPdSv/SUX?=
 =?us-ascii?Q?W7JXiaRSv7WdzRlqZmJa6LpmSZXcGflNiufY0yVAkXx/ucC/WloR25lkmwVu?=
 =?us-ascii?Q?DEa+W8dBiKNPDe6G8POlomwWUvDAfWENfMRfqvbTqQKBGkXJtWygbYE991uc?=
 =?us-ascii?Q?bK3cwmQ8vn3xzJDAl5Yv0k9cDIK1HbVz42gvWZLBsb8tjj+r3ysQVU/O5eFW?=
 =?us-ascii?Q?svA5c7eLLNVFMoeFh2JnxVUO8ahMh9FBgbAdxWoaan/6b3bSv/rRiaANNowN?=
 =?us-ascii?Q?0DXN48xzjLoXOcINF+wtt4sJDRmL6RjKLySMyotNsYe7h8FSH61dV4RTWBtA?=
 =?us-ascii?Q?Cg0JrVqRMfehBojHPTY/x9qfRbQq6/Pl+JGl/5der1bIs4tkAlVgCcerUAUp?=
 =?us-ascii?Q?AvcKL4TXZykRDcWfZevY6iY5YEOBl2nKIYpJimyjrFJ0rCYm0mRHGRrftrre?=
 =?us-ascii?Q?L/E/priDYOj1aYkOUmh5in1EsGvV82mr9c+AWl4vRhw0I1IgMFraEKg4f4nM?=
 =?us-ascii?Q?TKPrmIP39kSoMfSQOu0RM4fwDi3msF4FV/1iQFMn3NVB8uJZy1jqDSylov8F?=
 =?us-ascii?Q?fS1GHz9sFubTPZF8QEKsrSx6yrDqxS1bENSvZS0SJ5hiz59QtRiDUwdFs2GX?=
 =?us-ascii?Q?YfOP9d0UlKNoL7sfxPWjfzMehqojJQvDPtS5ujdrlBFTnydtEiA4oj20UA1q?=
 =?us-ascii?Q?70HI/2GQmFN5o+6oO0muq/DeFuQjlZJ23z+OrMgDjN7Uw83BdJ43UUVkhQbY?=
 =?us-ascii?Q?wjy6UGWWJ3F1sCWK1+M/HPJp3kY1+AWhXrUpxrdjd2yQtqQbxtIYtZXuvJNy?=
 =?us-ascii?Q?sFFwBv8f3YbZVykxTbGxXyeT1DIKSMDPEEXGCqWdIeA77M+LPrEhG0hYW/Ed?=
 =?us-ascii?Q?duE+W9II3v7Hc/ahiBkha+9pBb3Azu9aT+iRtb6pYb2RlIGK22hfousXN1w+?=
 =?us-ascii?Q?yhRU6pfiPsC4hE5POJny2hGqbsM4vz4hR39bkXHsz/bByYg56tofGCLRmDDc?=
 =?us-ascii?Q?9tq3pX68YMo6UjLyt2evsG1rhTQ2DuxUrP7hIyWg9Ol21wuvqyxCF5cdLvC+?=
 =?us-ascii?Q?HT847o3z7RderZ+kUv360yEqxx032lQKbN0cYhFwrfvPBRt1K5b5xakqjXb5?=
 =?us-ascii?Q?VQ+jjq023mMgFZ1LFojfosnty4Q9tiIusc2fshOdI5Wqz4j5+3om9UxheHB5?=
 =?us-ascii?Q?S0195dZTKeGq5Z+xg80yw9WhCnBHirOeUk8fQX6H0JdtMKkWq8L5wvYwHbUY?=
 =?us-ascii?Q?jO6N4cLHCRHVQOqM/GJeLaHvORS+gWzqV04kH26kc6hc6/0woInhSTpaSnkz?=
 =?us-ascii?Q?id0Bl7l6VlaPMa7qnVR/UMwmdTk5QdXUkqHf/CKliVwSP/YpqUvfUFtni6eo?=
 =?us-ascii?Q?CeV+oMyfb7ZVCgL4YZoHpAE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pwSnY273yaoNRC7giNJ5JBM74/MAMdIul7p6sJGlIT4SUbVlrz24VtXiZRjP?=
 =?us-ascii?Q?ys/ISh2PNR7gXt35qUsTL/oiL7mrtjWO2UrOv0GGv9rq2ig0xBQst5RWoDMX?=
 =?us-ascii?Q?DupHkZ2i3nRKVkecUyx2U6qUJ1zHBZNgX+19PYKi8TODg4ANURfWk4Iek9UP?=
 =?us-ascii?Q?1oIcpInmXcyK9ep7Zql5BxDcKbO/oor1jyFNyt3NMoGh0ewrlsqqHZvQVZim?=
 =?us-ascii?Q?VZE4CcfW2Hu33V7uFiui//s/aYC1hbxUDLKTtjopJw8/P/s674Gx6uHbCsa+?=
 =?us-ascii?Q?NM9cAHW0uymCprccsNOb9x/q6SvrOg4uFMa2iiRtKGspjTP6GACoRHsikSKZ?=
 =?us-ascii?Q?gJV1Bzwgcn5Yj3AGUVCyOAnChqlNmB5lm25TMM8nNF9lljHbRmuIIpe4KPn/?=
 =?us-ascii?Q?rexiwBJ4swadNJW0+VaAjXqmLXJDoE11cPQiEVmFwfhY3h9lIX7oXWsT6Q6Z?=
 =?us-ascii?Q?cTRLPa53UWMsjHmwcz2tQKoEh9MdobjEdvwzrLy35+756NdnUnkKa49Gzdy9?=
 =?us-ascii?Q?p68CbnxWrTKnjomvk+335Q7tLtxaQbHqrN0c3nipaqJ78ZdslgqrtJRb3xgB?=
 =?us-ascii?Q?g1wU5jiiUkd3SBRtqVOaWM3aqCi3aZwtX5IRlqNfmIiSsE/2H8x0zko7PBfU?=
 =?us-ascii?Q?RWGfFJd1eKH9hu2ylq+pk09LSyXR75qWHVgeS251tDRAQBgsJDJyzFPZ268C?=
 =?us-ascii?Q?1ISdYXby1aYKejNsJ+Pei+ZmdyQS1rH3mGGojtsIsjodGYW2QzMY0+vPQbkI?=
 =?us-ascii?Q?881B1TszXNsIaiNLDMWo16scHphDowmOjt6spkX0yAu6dCv+weUj/fHxHsRG?=
 =?us-ascii?Q?uye0wRKYg9IwGRSBQTkYj3A9OvBV8eaHzs5gTvvh02hk/Wt1rrXNbSOVGkL3?=
 =?us-ascii?Q?2MRxObstT/4DaFgfpLcdQXNjyP57XLylfRsHDPmIMYy8mpBkkToRF3tt+s6i?=
 =?us-ascii?Q?xSonhLcMRD0BzR/YmbwlWoXWFMpaDputjO6o1g0ZiSAvLtnIXIqoLE0IdTdj?=
 =?us-ascii?Q?0ym6o1wNaiywUoLHnZytPVBVXlptjNU9vahV2zEqE1BVlmEGNen/5yYXpj6G?=
 =?us-ascii?Q?MciaKLkd9M/+6wjD++TyswU/+Y6jUB/0CGy52s3YoS/GUAG6DMaL0hR2jAEL?=
 =?us-ascii?Q?55S/7zneUzSLe8A6K9Co0X32KsBBPCk2Qbjgaqv8Hd4KhU0XSOdTlHEcDNhF?=
 =?us-ascii?Q?gUh8a1s30JV3SecimMgfL4/hTHSOW4cxF4zn6T9L7tmI4avPlsaqsNMlmmlC?=
 =?us-ascii?Q?nhnX1dxVRp+s9D5Z1vuLMN+BlOHvIk/GKy4KR79rO0nQEovU0y4OOgcJeFgX?=
 =?us-ascii?Q?H++JA0uAaj6c6UB1qRftIyVn+/0li1j0UK7CmXy5gzcSHEsTPjRq7oxl5eGH?=
 =?us-ascii?Q?8XVyleXiNFP+PYOAQOj6+QC721Xac0O0qWYYz6gQofSIWANIbyNkpSBpN/8d?=
 =?us-ascii?Q?S8vIWISudVGmEIBMXp1FuyfTbiUlbNA6KlVeSv5qSdLA1IKRT2k695y2HYZ5?=
 =?us-ascii?Q?Z9jyZRIhhl9MipV/Qn7XYoHZXuAV9vIUnry6Y7fGCTe3TSg5GdhHn+wf2VMC?=
 =?us-ascii?Q?QJeIKPklUXne+ocOKODDX+taaVc5xVTnMx6KXvnYnGnVUnl0NjhGRmy9daXd?=
 =?us-ascii?Q?taYOLgRlJajlfG0cE1VCrECq9Gk7XCPj+Mqmvw2u64ldOW0HA9XM8sYNSH9s?=
 =?us-ascii?Q?D+t4Tf56Hs7NOA2E7+toT13S90d6GPAWaJcx3L+1cf8yxrXHfsb8kuqXHrkU?=
 =?us-ascii?Q?ZzIwkH6TqQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f755cc6b-a5ae-433a-6177-08de7259ee2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2026 21:32:50.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Jpj5qtpDV0FDRs1Q5JS4ryFQfXTnjpgOkbkIYxtmdQ5otufIFs3QnNj+OO1+TzfJXhZwA8EJ9ReuuDrEn93gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6873
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8940-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DC54170708
X-Rspamd-Action: no action



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, January 17, 2026 5:49 PM
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
> On Sat, 17 Jan 2026 18:01:18 +0000 Haiyang Zhang wrote:
> > > > Since this feature is not common to other NICs, can we use an
> > > > ethtool private flag instead?
> > >
> > > It's extremely common. Descriptor writeback at the granularity of one
> > > packet would kill PCIe performance. We just don't have uAPI so NICs
> > > either don't expose the knob or "reuse" another coalescing param.
> >
> > I see. So how about adding a new param like below to "ethtool -C"?
> > ethtool -C|--coalesce devname [rx-cqe-coalesce on|off]
>=20
> I don't think we need on / off, just the params.
> If someone needs on / off setting - the size to 1 is basically off.
>=20
> > > > When the flag is set, the CQE coalescing will be enabled and put
> > > > up to 4 pkts in a CQE. support
> > > > Does the "size" mean the max pks per CQE (1 or 4)?
> >  [...]
> >
> > In "ethtool -c" output, add a new value like this?
> > rx-cqe-frames:      (1 or 4 frames/CQE for this NIC)
>=20
> SG
>=20
> > > > The timeout value is not even exposed to driver, and subject to
> change
> > > > in the future. Also the HW mechanism is proprietary... So, can we
> not
> > > > "expose" the timeout value in "ethtool -c" outputs, because it's no=
t
> > > > available at driver level?
> > >
> > > Add it to the FW API and have FW send the current value to the driver=
?
> >
> > I don't know where is the timeout value in the HW / FW layers. Adding
> > new info to the HW/FW API needs other team's approval, and their work,
> > which will need a complex process and a long time.
> >
> > > You were concerned (in the commit msg) that there's a latency cost,
> > > which is fair but I think for 99% of users 2usec is absolutely
> > > not detectable (it takes longer for the CPU to wake). So I think it'd
> > > be very valuable to the user to understand the order of magnitude of
> > > latency we're talking about here.
> >
> > For now, may I document the 2us in the patch description? And add a
> > new item to the "ethtool -c" output, like "rx-cqe-usecs", label is as
> > "n/a" for now, while we work out with other teams on the time value
> > API at HW/FW layers? So, this CQE coalescing feature support won't be
> > blocked by this "2usec" info API for a long time?
>=20
> Please do it right. We are in no rush upstream. It can't be that hard
> to add a single API to the FW within a single organization..

I have sent out a patch to add two parameters for ethtool:
COALESCE_RX_CQE_FRAMES/NSECS

I will send out ethtool user cmd patch, and driver patches later, after
the new parameters are added to kernel.

Thanks,
- Haiyang


