Return-Path: <linux-hyperv+bounces-2485-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC491450D
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 10:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AB5B23107
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD65027F;
	Mon, 24 Jun 2024 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="H731VOCs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CF3EA71;
	Mon, 24 Jun 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218340; cv=fail; b=Ji1XJ4QgD1PHPpbg3T9M3cl/ZxxHD+6S62F2BExoqYqOYjpWlt02VNzMEvqsepu+dwSy8+a+MzIjcPXSgnocmEp/OeEVdz6s7P+9/FSvHIwxASEbnkvg2BhOAefaMfIIAMXFAOFwvPgjSnn6nLHY6B6nT8N/OV0OMeHOZqqnnc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218340; c=relaxed/simple;
	bh=lTnwBanNAsVYulhKf/XkkP1Oh9Da5jW1+TcOUGDJPpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iRnOIIOX78NDbSzB+CvB5vdZrztFIQHjs18+NbXFTzhv+zELvJ8x9Im6mlOsshpgd+VsfZeBWNgtiyAhcMvyL7jDJrJdAjObmL3nqhqglGWUQPjn1y1luYl/1BTfEHB8ij6T5DAZjiae1Rhp5u50cwwhJSGQAXA0qdqFaA0iVY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=H731VOCs; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8AQxr010082;
	Mon, 24 Jun 2024 01:38:18 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ywx4gc1g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 01:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwt+xNyh8z9h67/w2o9xxL9X3/X/RYbZsTZCAmMdgZ5PvsXzx7mjmhT3v9tyY3Swa6svks23lzxChxEqbYSrkBJmmmW7IkUYihFhIAqwVw9t8283q17hlZYFvHu8diUOYmyrTEiWFYxNYSuN0dJa5zqNidL0v39rwifcY4ysy9rZFXGjpoxKQY0wpTj7YXE9b4dBAiS3U1KsRNJOmjKNEIuehhIK8+STDuruLy9vet5w1r2EBACknuNAP2tN9T456C4dY9gbKu24KybbYGpuWOcX68YBYOcdeT/UxV6whn8qFrZgjczVpqe6dCREOQGxcpSDNDenjaGxN1bM8X9DZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTnwBanNAsVYulhKf/XkkP1Oh9Da5jW1+TcOUGDJPpk=;
 b=SdH27Lc35NYN8b1+JjG/9iFpsJ5Cg0mlcgKkx3wKcve2V9tuMWeRaZ7/I7dq9zodwOQh4UNhKgMWz1XWwjnYR81B9rdQW/XvzKqYBGqTq0Cx0iGgyF3GavGsnZ5Ir2Q/RgIBFycb1lVLkWVT1qfItL976Vcfc9dIzzJvsdZRKOpzqcK6kOq1IdhQ/Zb1hlvxViw7bPZcr5GGljXerVQTAMFgId97bil1CRXrJtY/mwyotU8e2A3MMsCpriLrnzTr+55Wqv2N3efxAHJ7iC24K2D9ls0GVC2jYIebc/IRRqjoLoYtFkLJIYinmIytUzJuJBon17cHvTEmMSNiMMWMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTnwBanNAsVYulhKf/XkkP1Oh9Da5jW1+TcOUGDJPpk=;
 b=H731VOCsbqQjhxxTllFCbpfguA/aeOTDWGYYPqYO7lU+cnh7Ih5Vyqql8EUYgx7+bClnhZOSQlNlb5xr+LlRkZFfTChdYoGmpKF9WRFsun5luyMOkzXfUhpbTWdjlbB4pUxZ30WaPRcygVxTCxfOQFLH0+u5h/832XE1p2kjCWU=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by BY1PR18MB5952.namprd18.prod.outlook.com (2603:10b6:a03:4b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 08:38:15 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:38:15 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Ma Ke <make24@iscas.ac.cn>, "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org"
	<wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kotaranov@microsoft.com" <kotaranov@microsoft.com>,
        "linyunsheng@huawei.com"
	<linyunsheng@huawei.com>,
        "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>,
        "erick.archer@outlook.com"
	<erick.archer@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Fix possible double free in error handling
 path
Thread-Topic: [PATCH] net: mana: Fix possible double free in error handling
 path
Thread-Index: AQHaxhHbIqFaCMxKQkmBA9OiqxGt5w==
Date: Mon, 24 Jun 2024 08:38:15 +0000
Message-ID: 
 <BY3PR18MB47074E845C5C5CD540C8552DA0D42@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240624032112.2286526-1-make24@iscas.ac.cn>
In-Reply-To: <20240624032112.2286526-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|BY1PR18MB5952:EE_
x-ms-office365-filtering-correlation-id: f75bb372-1344-4684-d9ef-08dc9428fdb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|376011|1800799021|7416011|921017|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ak1acUV4RlhkakxmNVhHKzNFdXp1T1pOYzN6SHAzdHZ4MW9MR0Y0RnRPK1p4?=
 =?utf-8?B?YnVscUo1eHRUTmZvbGxSOXBLSmQ5WEpSVEV1aXptZDlDZm1TTWdMbU82bW4r?=
 =?utf-8?B?cDVlNXY5bW5sZXJpcmpOWFhEejNVajJ0eEt2NlorUndhS0dPVE83M1B1U0JX?=
 =?utf-8?B?UHNjaVdkdEVsamppNDF6c2w5YzMvcENqTll3TU0xS1BxMnR6RkE5NXJ5VlZZ?=
 =?utf-8?B?aWpteGlTSURyUmVFbnh2aDUvdnhhVCtIZjJwZWlETG9wSmladzdxRUFnMUdF?=
 =?utf-8?B?akkvREhLRU1HdEF3QjdYOE9kZHA0ZGJ2aGJtOW0wcUxLajhrL0tjRkJRKzZ1?=
 =?utf-8?B?VVpNUEhtN2F4aVJhNkhlNW1ra3g1RGpPTXpLejBkODR6aUNRNkVNaEZ2MUt3?=
 =?utf-8?B?d05RZ2ZNVTIxMGNpRHYwa1ZuL3d2ekNraUJkOElwR0hMMmR0alNqZEhKdWE1?=
 =?utf-8?B?U0xQaVVpV0VSR3B6WkIrcmFtVUkrbGpOTm1OMzlUQjYrTkRsWXNtTHlsV1Vm?=
 =?utf-8?B?Y25yT3BiRUFYaEVsQTFTUHBLUmFSYWV5QitwbmRCVWMwYnE2SzVIcGFiOHZl?=
 =?utf-8?B?L0d3UFI4b1hKSHhsdS8xRnRDWjB0L2pNTExNeCtwU25aS3VIU2hXdHNRZjVQ?=
 =?utf-8?B?UmE5eWNHV1VJY0pTSXdmMk56dC92MlhqSGRLVGlyQkk2RHZRb09DQ3NxZ3BB?=
 =?utf-8?B?OWZmUDVySk5ENCs3aXN6aXpzbVJNMHNxelU2VVFST0x0dkZJaTVHVUR5WitB?=
 =?utf-8?B?aFFSY1lVSW90aE92TU95S0JXQS9vVzloSDN5QVBHL29TakJYNUJHckNlL1VQ?=
 =?utf-8?B?dHNTd1dBQzVRMGZVUGQzTEZVZ2RHdFpRcTlOTkVzNjF3NWQ5RGtycURlS3U5?=
 =?utf-8?B?LzF0MWEyK1lvUmE1YUsrNG9ZaVlTQU90RGt3UFZUQkhnYSt5Rlk1Tlk4bTd0?=
 =?utf-8?B?NSsxVGVmeVNDUTNkcjBhS1VrbUZGQXhrcDhWU0VjTGVwakE2UVgrUVB6cHF5?=
 =?utf-8?B?bHhYSlFNSUE5T1hDbnBBZDR3SDlvdDExSVU2R25GenZSUmk2aEJjTy9vVlF4?=
 =?utf-8?B?TmxwdTRXU0ppZ1A5Y2g0Q2RvN0k5S0pNMUVyVTJVZVNDa05ON2tualRIdXha?=
 =?utf-8?B?RDFOczY2UXVzTlFEVHpNVnZ6c3orTGVsODNvSzFKUzROU1p5aC9iUE5zSEw4?=
 =?utf-8?B?ZTFvYXRZcDFRcVNMU1Z2N1FpdFRxYUpDRU1XT08rWmx3ZXYvL3BrZ2NndTVQ?=
 =?utf-8?B?VWVpb1k2cytIZjJkSmVoV2FpT3VHeTF6QjlDdmRzQU1xbEpSemRFTTI0Q242?=
 =?utf-8?B?TjlIRnBTVTB5Zm9nL3FMbWcrTWxGYVdGSFMxVXFKZDR6U1p6MlR2aStvTXJi?=
 =?utf-8?B?ZllkZGNQWmgySFgwWUNsaWplblFjbVdtQVVsbDl3aHdmZ0cwV2piaWg1N3Rj?=
 =?utf-8?B?V3FMakRxU2djeXlONlEyMUFZV0tLcVVqbWkyT2FpaGVhMCtiUEVMN0RwbTA2?=
 =?utf-8?B?ZVZ5T2JnUzZ4T2prU1QwRkc0QThadTZORXpsaTlNUlN5d0d2ZFNURzBOdWYz?=
 =?utf-8?B?VElEZFVSU2pmM3gxU2kxTUdrVGhMZzNTWmQ1SFoxaXlxTWxXbTk5czBRdTgv?=
 =?utf-8?B?amhqR0hUQWR4WVFvVDM2SDlyRXZrY3Z2Y1ZLUzFPQTRLMWJBdGh2d1ZnVXBE?=
 =?utf-8?B?NHUrSXAwbUhuTkZOUVVrYlA2QVJQbVBiSWNMV0swZzQ2S2htYW5lVTFXYjBI?=
 =?utf-8?B?eXZZOU9Jd0hCSFZLYVpWUm96SXZ2RTVzUXhvdklkWU9LcGdQMWdrYS8zYnQ3?=
 =?utf-8?B?MTZSZm9Gb2hYd2ZMZUpQRm9EdUU5NEE2Nm1JYkZpZEprL3l5Z2tETTdoVE95?=
 =?utf-8?Q?Wnh3Il2oVoSwr?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(7416011)(921017)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZkYyVXdqelR5OEVTZm9GcUJYWVhDbVpDNjFGeU1EZVB0VFM5bm1ZRUNnbnp0?=
 =?utf-8?B?LzNRd1pMM3FMcW5Va3A2bUNkT2JRbUphdUxxcldMUmMvVllETWhWakRRamtI?=
 =?utf-8?B?YWNiU0tYbkRnN2JuamNCMThZdnhVQmlCbmRVU25GWUNzeDFrRjlEOEFveC94?=
 =?utf-8?B?Y1p6K1B4SGJUNmJnZENIS3l4Wno1b0QremJzOUxwZEJaRE40Q1RKelhPSjhH?=
 =?utf-8?B?NUk1a09BdzY1eVExbjVpNUlRWStKRlQvSlB3VkZBbnRjRXh6d2JSdUI1b1B1?=
 =?utf-8?B?S0Q1Z3pnNWNOK0oxWGhYVlRkMVVnazVXUGJHWjNkTjdOYVUwd0t6akVnUDVF?=
 =?utf-8?B?M2JFVGJ2T0hQdWVGUXhmS2VITWF4OVFJMVllS1R1b0syR3JqTmxxWE1udk8y?=
 =?utf-8?B?S3pBbzRGRTR6L25RWndaeWJsTzltYVRuUHRwdUVTWEdleVZESWd5cGc3YTVS?=
 =?utf-8?B?WUUrbTk5TEhUWUthZmU1WjhFTXhBZUpYVk1wU3E0ekVjdlo1MGFpQjJPSTRx?=
 =?utf-8?B?TFBNUDJZQUEzRmcxQ1lqUHJOUTMycnJ0U3A0THlWS29PK2tsR1lEajV2UzU1?=
 =?utf-8?B?VUk5c3dhSC80MUQrMGVHYU5GVXJKLzJlUTcyQ1N1aUNHVXJaekNkR0NLM3BM?=
 =?utf-8?B?OEYzMUEwQzRIRGU4NXQxcVU0aVVXd0xTc0ZtUWVxNEIyWERxV29oT3JEZHhL?=
 =?utf-8?B?WTBIeW8ydjhFTHJqeTBLMmNydDBxYmVmbW51eCtZTU1HckhLUlJGemJvUzVI?=
 =?utf-8?B?K2I3N2FORHZLd1g0K2lPYUh3VlBkZXpFUEhyL0lvYnBqdnVjMVV3djA2RjE1?=
 =?utf-8?B?R0MxVldjd1R5MlJKNFNaSEVseTBNR0s0a1RNUUZZS3Bjb3dGa1BYTTd5cGpo?=
 =?utf-8?B?TDlIVWpWZ2w5cnpuNUIxOTcxRXpDaXJzYmlORkM5cUxaVm80Z0k0Q1Z3Ti93?=
 =?utf-8?B?ZGxET2s0aFNoYjczdVU4NENFZ3RyYzZlVVBRSEdjcEFVK0RweDFCUWNyNU5C?=
 =?utf-8?B?MTZKQ1B2b0l4elpUQzF4cjVTWmVrUXFFelFSNTJ0UFN4dExTMkU4L0RnUzhB?=
 =?utf-8?B?MVM4MFhVbE1BREgzVUVaNExwWEtPQklnYXVoN1ZSd01zTHhUakpaYXdpVFpD?=
 =?utf-8?B?NzZTRmlEOU1KQlVVK3pyOGpEaXlSVkl6R283Vm15QkZWUzYzTWxZMjRhNkFm?=
 =?utf-8?B?VmhHY2lic0VtUWRWc0tmL3hydmtpdkZZQTVJdUFVczl4MHNSY2lvV2VBVWxi?=
 =?utf-8?B?cjZpSklKTktOL0F5cGJickdQWUgzYUxjYk12R3R0L09ibXBhVlBCcnB2Sm1x?=
 =?utf-8?B?TEp6R2p6Qnpoc0pYbzVyQlRrUTdVaytMbEhBU1grRUQzc3VCNDc1K1pUK0xj?=
 =?utf-8?B?TFFTMGFuMy9TKytDdmVmSVFyVXE2TFpUTUltODBGcWIxaHZUUC9VTWpGZnV3?=
 =?utf-8?B?ak5Sd3FveG4xU0ViZ3lNdWEyclRxdE9UZGlDamJxUlEzQU1ES3JJZUswT0xS?=
 =?utf-8?B?aUd6QTcxYTArdHlMWEVZQ2VwODdFLzg5OFozZFBYYUliV1hIejl0cUw2N2Ir?=
 =?utf-8?B?b08vSGplWklPSm1UdkpWUUcyeGI2NUVoaWxIWk0xYnhwd1JLSEl2OWcyaE9w?=
 =?utf-8?B?NGJ6WS9kL0MreG9uSkxKejFROGhYeWRFOU9OMG92M3RSaWpVdlI5YXdmMkpt?=
 =?utf-8?B?OFY2VHAxNWx0OTlNVG51ZlVqcjNKM1VKSElMQ0RKVWtTaklRTkwrZUFDV3ZF?=
 =?utf-8?B?MkxUTFRQOFB5NTMzbHIrVUsvZlBDM0NUOXUwWTJxcVJXYmN4UEtqRGo2ay9F?=
 =?utf-8?B?RmVUQU1rcFp2VC92YTR0QXpTZzNzZG8vZDh4OG9acXNkWjhBcG9vT1hxTnFl?=
 =?utf-8?B?TXlFMXF1KzNaZmVBblZCVkpvVE8yckpRU1kwWCtQYmpVdU1xWUlWZnpQaHNz?=
 =?utf-8?B?WFRRNk5RTmg0QmZ1WmtNbllSb2oxM1llSFAwR2x6NFdBOVlFalFIOWEvdnZX?=
 =?utf-8?B?eDBUMWdhYVJGcy9CTC9QcHlZeWZVYWFvTWI5VGl1L0FEdjk1MUZoaVNENEo4?=
 =?utf-8?B?d0xxMXh0dW5MWWlXdHE2TUtDdG1pcS9ST3VzaVlGWXhUTG8yL1UrVWE3YmY1?=
 =?utf-8?Q?BRspkDNdHu5GU6oA/Vi+uPclg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75bb372-1344-4684-d9ef-08dc9428fdb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 08:38:15.5283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVr40B7QklYMgVjGW2doOw5Tl75fKmfeA6SA/MFUTy5yuIL9jT3DEnCjHA676/MF/oorHXeeVK/9KfKQOUm20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5952
X-Proofpoint-GUID: Sjc6dclqcxueX4oNyEuw0LTv0M8aQkAo
X-Proofpoint-ORIG-GUID: Sjc6dclqcxueX4oNyEuw0LTv0M8aQkAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_07,2024-06-21_01,2024-05-17_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hIEtlIDxtYWtlMjRAaXNj
YXMuYWMuY24+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNCwgMjAyNCA4OjUxIEFNDQo+IFRvOiBr
eXNAbWljcm9zb2Z0LmNvbTsgaGFpeWFuZ3pAbWljcm9zb2Z0LmNvbTsgd2VpLmxpdUBrZXJuZWwu
b3JnOw0KPiBkZWN1aUBtaWNyb3NvZnQuY29tOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpl
dEBnb29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBzaHJh
ZGhhZ3VwdGFAbGludXgubWljcm9zb2Z0LmNvbTsNCj4gaG9ybXNAa2VybmVsLm9yZzsga290YXJh
bm92QG1pY3Jvc29mdC5jb207IGxpbnl1bnNoZW5nQGh1YXdlaS5jb207DQo+IHNjaGFrcmFiYXJ0
aUBsaW51eC5taWNyb3NvZnQuY29tOyBtYWtlMjRAaXNjYXMuYWMuY247DQo+IGVyaWNrLmFyY2hl
ckBvdXRsb29rLmNvbQ0KPiBDYzogbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIXSBuZXQ6IG1hbmE6IEZpeCBwb3NzaWJsZSBkb3VibGUgZnJlZSBpbiBlcnJv
cg0KPiBoYW5kbGluZyBwYXRoDQo+IA0KPiBXaGVuIGF1eGlsaWFyeV9kZXZpY2VfYWRkKCkgcmV0
dXJucyBlcnJvciBhbmQgdGhlbiBjYWxscw0KPiBhdXhpbGlhcnlfZGV2aWNlX3VuaW5pdCgpLCBj
YWxsYmFjayBmdW5jdGlvbiBhZGV2X3JlbGVhc2UgY2FsbHMga2ZyZWUobWFkZXYpDQo+IHRvIGZy
ZWUgbWVtb3J5LiBXZSBzaG91bGRuJ3QgY2FsbCBrZnJlZShwYWRldikgYWdhaW4gaW4gdGhlIGVy
cm9yIGhhbmRsaW5nDQo+IHBhdGguIFNpZ25lZC1vZmYtYnk6IE1hIEtlIDxtYWtlMjRA4oCKaXNj
YXMu4oCKYWMu4oCKY24+DQoNCj4gV2hlbiBhdXhpbGlhcnlfZGV2aWNlX2FkZCgpIHJldHVybnMg
ZXJyb3IgYW5kIHRoZW4gY2FsbHMNCj4gYXV4aWxpYXJ5X2RldmljZV91bmluaXQoKSwgY2FsbGJh
Y2sgZnVuY3Rpb24gYWRldl9yZWxlYXNlIGNhbGxzIGtmcmVlKG1hZGV2KQ0KPiB0byBmcmVlIG1l
bW9yeS4gV2Ugc2hvdWxkbid0IGNhbGwga2ZyZWUocGFkZXYpIGFnYWluIGluIHRoZSBlcnJvciBo
YW5kbGluZw0KPiBwYXRoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWEgS2UgPG1ha2UyNEBpc2Nh
cy5hYy5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9t
YW5hX2VuLmMgfCAzMSArKysrKysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9lbi5jDQo+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9lbi5jDQo+IGluZGV4IGQwODdjZjk1NGY3NS4u
MTc1NGM5MmE2YzE1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3Nv
ZnQvbWFuYS9tYW5hX2VuLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0
L21hbmEvbWFuYV9lbi5jDQo+IEBAIC0yNzg1LDggKzI3ODUsMTAgQEAgc3RhdGljIGludCBhZGRf
YWRldihzdHJ1Y3QgZ2RtYV9kZXYgKmdkKQ0KPiANCj4gIAlhZGV2ID0gJm1hZGV2LT5hZGV2Ow0K
PiAgCXJldCA9IG1hbmFfYWRldl9pZHhfYWxsb2MoKTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gLQkJ
Z290byBpZHhfZmFpbDsNCj4gKwlpZiAocmV0IDwgMCkgew0KPiArCQlrZnJlZShtYWRldik7DQo+
ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiAgCWFkZXYtPmlkID0gcmV0Ow0KPiANCj4gIAlhZGV2
LT5uYW1lID0gInJkbWEiOw0KPiBAQCAtMjc5NSwyNiArMjc5NywyMSBAQCBzdGF0aWMgaW50IGFk
ZF9hZGV2KHN0cnVjdCBnZG1hX2RldiAqZ2QpDQo+ICAJbWFkZXYtPm1kZXYgPSBnZDsNCj4gDQo+
ICAJcmV0ID0gYXV4aWxpYXJ5X2RldmljZV9pbml0KGFkZXYpOw0KPiAtCWlmIChyZXQpDQo+IC0J
CWdvdG8gaW5pdF9mYWlsOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJbWFuYV9hZGV2X2lkeF9mcmVl
KGFkZXYtPmlkKTsNCj4gKwkJa2ZyZWUobWFkZXYpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCX0N
Cj4gDQo+ICAJcmV0ID0gYXV4aWxpYXJ5X2RldmljZV9hZGQoYWRldik7DQo+IC0JaWYgKHJldCkN
Cj4gLQkJZ290byBhZGRfZmFpbDsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWF1eGlsaWFyeV9kZXZp
Y2VfdW5pbml0KGFkZXYpOw0KPiArCQltYW5hX2FkZXZfaWR4X2ZyZWUoYWRldi0+aWQpOw0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gDQo+ICAJZ2QtPmFkZXYgPSBhZGV2Ow0KPiAgCXJldHVy
biAwOw0KPiAtDQo+IC1hZGRfZmFpbDoNCj4gLQlhdXhpbGlhcnlfZGV2aWNlX3VuaW5pdChhZGV2
KTsNCj4gLQ0KPiAtaW5pdF9mYWlsOg0KPiAtCW1hbmFfYWRldl9pZHhfZnJlZShhZGV2LT5pZCk7
DQo+IC0NCj4gLWlkeF9mYWlsOg0KPiAtCWtmcmVlKG1hZGV2KTsNCkkgdGhpbmsgeW91IGNhbiBq
dXN0IGF2b2lkIHVzaW5nIGFkZF9mYWlsIGFuZCBrZWVwL3JldGFpbiByZXN0IG9mIGluaXRfZmFp
bCwgaWR4X2ZhaWwgY29uZGl0aW9ucyBpbiBvbGQgd2F5IHJpZ2h0Pw0KPiAtDQo+IC0JcmV0dXJu
IHJldDsNCj4gIH0NCj4gDQo+ICBpbnQgbWFuYV9wcm9iZShzdHJ1Y3QgZ2RtYV9kZXYgKmdkLCBi
b29sIHJlc3VtaW5nKQ0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==

