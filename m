Return-Path: <linux-hyperv+bounces-6269-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81442B07ADB
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C03164BE2
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166702F237B;
	Wed, 16 Jul 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f5d4ie0A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021135.outbound.protection.outlook.com [52.101.57.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AE263C8C;
	Wed, 16 Jul 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682548; cv=fail; b=UasIOYmNAHbKOu/LeKDkJnch3p27tTOG72kSHUmOWt33rdHT2Uabh5FAPEV815yObvJZMKevdVUzKG8RrtB51Q54uIfUdJcsdPr6jt6YMW5r/coEBFFAqIewUl8sW1GqYESo8mWLqvhBM+VJxL9JSzYBaYXJpx2dr83Lswtev4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682548; c=relaxed/simple;
	bh=U/a4Hc2S8rYlvYdzyFMVrpnGExPyDgJ2Tt3Itk+djOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O8Gu3B+Oj9B0N+CqzD653eoAOhSG5UYgotJrOIZit9MBToK2yqbUr6bzvlizA+9oLUFWwaKMwHuU4QDq10X2sb7frwV2HZFfDsFo7gTDPd9j78kg1pen/CmlYlQ+M5Yz/XE6b6UR7Fj6HUwTwSC0CyHW72cpcJvfPNTAJxyt4HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=f5d4ie0A; arc=fail smtp.client-ip=52.101.57.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BySdy8oMpZPT1sO0HQPclQJmq1XkorRlzJjxWgQ8YhG45/KRdPdhPirFIqpT1dXmfJV4VGezFROBdnrl4+3RpscEBux3eqJKX6jn+SnR4mQNXLQa7/48KJ/IF9LLUGOD2uuEAr3Q/VSJz5LmrMSP3bflR3hY6g0TeH3ijk95afZDAA0cLkZHQkFmMk+yoAVz70i/Nh21bGOo892gmusqMrPrLo7gDYryVJZRUZIqjoMPZqh8nSvCAywnakUgxkFb+i7OTWVjai/hSYWr46MwLzUuh/eBOZq3E5cOv9HAWgq2sJyvPs2UKHftjl8aO+ejENgefPEQuVeMIPCgHVESxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/a4Hc2S8rYlvYdzyFMVrpnGExPyDgJ2Tt3Itk+djOU=;
 b=GQfaxbzEpLvTjqFEZ6t2U5kxdiBUFFcTJpVJxejFoatqQcduqxHYhHd+jK2TG+57mboE5+eQ4yp2f9iMsf+EQXRoaBHuML1C6NfEdpPoCdVmRaqoMNqFQTLqNMv0hcMsWmJ/jlQFfnJSBq9qhvyoKfCTpJPBXIAtg75xKB9CS/sdtRPCTNKqeb2QCmaXsZjWs5jC74Cb0tvYtm37ABo52i8bTqRbc+VC1YcNuEX6/tse/Uy6Ux63TLBemFLPQmOIykxUL8ceVULEm7/lhWFvI3lBoc3222PHUkMhwLiz0duSgwN2n0kPPNrU+RbLsjguhx22xf4SHBNr1EBZyn2t3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/a4Hc2S8rYlvYdzyFMVrpnGExPyDgJ2Tt3Itk+djOU=;
 b=f5d4ie0AYHqbIBhDScewflX579+pTIcVU2ij27dC+C/43+yAJZPqu4BvU4yT68acSOspRx5TLpsnnGCEczAhlLeglTlUr5pFF4060fYJryLpvl7UA1GSBDQSbDUPh8MBpyF1SFyyNbVUE7u2wScr9BUw+xGcRokCvuFok7zD91Y=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by SA1PR21MB2017.namprd21.prod.outlook.com (2603:10b6:806:1b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.15; Wed, 16 Jul
 2025 16:15:42 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%5]) with mapi id 15.20.8964.014; Wed, 16 Jul 2025
 16:15:42 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Xin Long <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>
CC: Li Tian <litian@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, Stephen
 Hemminger <stephen@networkplumber.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3] hv_netvsc: Set VF priv_flags to
 IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hv_netvsc: Set VF priv_flags to
 IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Thread-Index: AQHb9jQm2u0A00GXykGUNYpEL9Ndi7Q03DuAgAAQW5A=
Date: Wed, 16 Jul 2025 16:15:42 +0000
Message-ID:
 <SN6PR2101MB0943EAAB55E0BF97E0841419CA56A@SN6PR2101MB0943.namprd21.prod.outlook.com>
References: <20250716002607.4927-1-litian@redhat.com>
 <20250716092927.GO721198@horms.kernel.org>
 <CADvbK_cdOTO_UVg6ovx-Si7-ja=ErYw-MnSnR-CL4HwmtKJ8YQ@mail.gmail.com>
In-Reply-To:
 <CADvbK_cdOTO_UVg6ovx-Si7-ja=ErYw-MnSnR-CL4HwmtKJ8YQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=83f1b055-d717-4562-acef-b67a85aeb2ab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-16T16:12:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|SA1PR21MB2017:EE_
x-ms-office365-filtering-correlation-id: 4429d415-ecba-4da7-04eb-08ddc484030c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VExGOFROS0xqellzVkN1U09HU0RVMWM1UCs2NXh0UUhvUzRmTU9JbERiVDNw?=
 =?utf-8?B?bFR4bUFJZnppTTZqSzB2K2d5cWJUL2ZxTnUxS3g0WUdWQ29rYndIVUxiMWZv?=
 =?utf-8?B?cld4Q2t0bnVYM1pBM2V0Wjd3ZG8weGNwQVMxQ0ovdko1eHBpRWxOUkk3OGVW?=
 =?utf-8?B?Wk5IUk5WbUphS2xjZW92enBQcThKeksremJkbUJzRlpjeUVzZEFPNk53WlVU?=
 =?utf-8?B?Nm1GWFVjRUZQY0dIWEVpZ1Z1R1UrcmtFVFoveDFEaUdTVVFFc25VRTFoamNN?=
 =?utf-8?B?d3AwMzMrTkNBZG1TWXdoZVZMTHlVRlROK0xEeWlIRnkzbXRCaXhSOUVoRC93?=
 =?utf-8?B?OXgzdXpEN0t3czlxUUNLS2w2anFpcmJwRjd6dlpjQWk1YjhqRm9LbmZlK2xP?=
 =?utf-8?B?ekgrTVFONDh0MzlpSGlsNHFKT3BSSjkzMHhOU2puYURxNHkzVXdVQlIyVVlx?=
 =?utf-8?B?RTl4dWtnR1BhNlhySXozckZscGFybUNuUVRBVjM3eElFK04yOGVWQmxHNEZw?=
 =?utf-8?B?Uko4QlRjNFlVVXR3eUNlS3JrdDV5U0NsSmU5Z2NmVzg5Tk5tekRQbUp1TFB5?=
 =?utf-8?B?ZVZjRUhwL21GYkh5a0hHRmNlTTdMUzg2VkdwcSsxVmRvR1Fvc1VzbXM5NGR5?=
 =?utf-8?B?a0xGUC9OYlRGVXR3bUlRdkJEZTViY1VRbHR5TWJJSm1PTlZNRTZrSzF6R1dr?=
 =?utf-8?B?OUwxK2wybEYrL3lxb2RLNnRsRHR6Yi85NHo3THJoZTVKbmFHN1hsY1B3Znhy?=
 =?utf-8?B?RUdzQnN1cWd2UEhUcmFVTndBMkpOUDZCV1N3YXhCc3Q5RklqNE1iSllaaVky?=
 =?utf-8?B?aXNjNVExc1A4U0VMaGE4N05KNTY1Q3VzRmZpOG1MdjYvVm1mc0R2TWc5akZV?=
 =?utf-8?B?VWZVR2hkdmxteDNuMFFVSUtsVG1kaHpQeU9hWUhCRWlTS1FTR0ZPVk5udmV4?=
 =?utf-8?B?VkJCR09ESW9KY1ZDaFd1OUllbHZmVHIyYlluOTJwVktUaG0vK3dKTEhLelBk?=
 =?utf-8?B?Yy9ISnFTTGdjVFVHYjZjMFd5ZGs0UFAxaHhYSGVCSzRldUMvZlJDVjdjMkJm?=
 =?utf-8?B?TUFvK2dCd1YvelhxRW5Gbk9SWVQ5N2FUaFJQZlk5WkxSYlB2bHlYVng5M0Ny?=
 =?utf-8?B?dTg5UnhQNVV6R0ZSVW5hazNmdHhqeG5JV25CNWQ3QWNqdlJUak90anBTM1pa?=
 =?utf-8?B?Z3lmMFQwbTF3NHZRS0NNVlFmcmI0dlJWdTVsNXltV0xXcW50bFcxa1htUjMr?=
 =?utf-8?B?emVQNk41VHVTcC8ydGVEeXVMcnFteEU4SlE2eEhVTU1EaFJCZm80aHdqTjFw?=
 =?utf-8?B?Ykk3cUdoWmpTN2dvMU9TUnhIVEFUSnIzZDlEYy80cWFvTFB5bkhSTG81dERn?=
 =?utf-8?B?alE0Vk81eFFJaEoyZ2s5d1BEV1VzblRnQWJwcTg4S2tndHFJNUhmNFc2YnE2?=
 =?utf-8?B?Y2dvZmtkZGFwVU1WY2tmRHFycTR6aTVyNUIvRTF2SHp5RUxYLzRjd0dSTE11?=
 =?utf-8?B?cklmQ29yazdCU2tmTms3TytWcXRON3ZsQTZ3cU9vS2xPN3FneERSZVhQdWt6?=
 =?utf-8?B?U1BtNno4dCs0M0ZrL2RESUF1N2dCNEVBZ1RoME0wVWw5eWtCaCtob1J3ZWRr?=
 =?utf-8?B?QUl2RjNTVlZTWDMxRlovZjhnc3ZHU1Y2NGxZdGlvbUpZeVBpN09mVWpXQU1v?=
 =?utf-8?B?R2pFa2M0ZUNpQmNmWGc1MkVwbElmTVIxcWhHQllKQ3Mya043cFFMVDNnQWxY?=
 =?utf-8?B?Z3pZaDlaVHpROERoUzF2RktGQTdxSTNtR09UR0RZNExtd1ZjRlZQRXNjQkh3?=
 =?utf-8?B?aUpVUHFFemNYSW5icSs3aVc5bmd1TzNWWnQ5UFBYZ3EzME5tL0JZMWFGZXow?=
 =?utf-8?B?SW01R1VhYWwxUzlXZlloRlBqclA2ZkpubkJxOTRta2dJYXBTaGVWdWUyYXMr?=
 =?utf-8?Q?yfs7zzKNo48=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2lXa3p5TDUxbE1qb0JpMTBzeUdtaWE4WFVPUWNkUE5EbHZHRFc2QmR5SHJC?=
 =?utf-8?B?RnB5eUNCNUhpbFNxRmsvTEhFSFZxMGdHN2tla0lTNzYvTmpmNFNEbDVtK2pC?=
 =?utf-8?B?bVY4ZHViU25USG15S3ByaXRRTnZyZVR0TERaQ3JuMFBTb0FrYlBnTURRcWRh?=
 =?utf-8?B?ZTBsRVZzUExkaSszU2xINERqUTN3WFd1c0Y1ejBORTNzYnc5ckRJYWFYYjlI?=
 =?utf-8?B?SHUyVUZudDZFaDc0ZkpHbDhTY2ZKZnNENUpjY1ZwTWVteFhqZTJoeEFQeFlo?=
 =?utf-8?B?VmVJaDVYRHpHOUhEaStLbkJTZWlHWFpDa3AzWkFhMktGTjFoNUhDaXVhKzNU?=
 =?utf-8?B?cjZWR1MzenhGbTVBNWRRMThiU2Q3NVhWWXBZK0xSQ1dDWGVZTm1SY1RVdGNY?=
 =?utf-8?B?TUtCSVovSTBEVFdUSmFGL004YTJtRmNhUlZHRkREQnF6b1lhTWtXWUt2NmNQ?=
 =?utf-8?B?R3RnNWNrblpjWFBGMHN1NGJEQVpwRndxRUxBcUErME4zQVFUQjNkQWRLamJm?=
 =?utf-8?B?MDJCRVRUSDhrV1V1NGkydU90SjJpdXhGeHdSQUtzcG5VcjdzcHhpaXUxSy80?=
 =?utf-8?B?R1VXalpNbUpUMG1zbG1ZOG92RlJYVGgxV0pqMmZkTW9tT3V2RGJ3ZXVkR2Zh?=
 =?utf-8?B?UEpEZEJ3MXVMaWxJVDRjL0dTOW8wMW84WHBYZnBVekpCejNNT1hPbUx2YmlZ?=
 =?utf-8?B?ZzhLeU80UmRKS3gxTTQrU3lsYjAyeVpUdXdkbUFaMDQ3V2FKdStSTU5lcHZi?=
 =?utf-8?B?NUh5eCtWYkFiUzltSExiZjczdG5IamdRL21TeEpSOENuaWQyVGNGaFUwd2xl?=
 =?utf-8?B?U2l0L1dtc1UzaE0zMHJZeFBvTS9rOGpKdWxTVVFGLzJvYTA0NmpnOXE0SjNE?=
 =?utf-8?B?dzkxZi9xRll5YzYxSm0yci9WbjZrRHk2dllUbDhlNnc4b1NhTzhRTFcwL1RD?=
 =?utf-8?B?ZDlYaVhVcXMwMktVZU5wNWhsZ2ZHK1ljbnZuRWZBam1idXkrT09XaFZ1RkNo?=
 =?utf-8?B?R3hTeVNUT0FkM1ZuM243Q2czTzUyK0JBdHgzcmZ4WUd2VmYyZk9TV25Db0ND?=
 =?utf-8?B?SkMvZnZFczBPc0VNbGlZNWR0cXRqU2didkJiRTlTRWdIUGVwcGR1dklvMDRL?=
 =?utf-8?B?dU9vY3F2SGZKcXVuUUMxREczN0NYaFZZQU1Fb0JTOGwvZ3VlRUhuTXVleDNr?=
 =?utf-8?B?UGR5SFZGaVJ5ZkJhQVRMK3dsQ3U2WHZ3bm9PenZBZGVtTkFlWWRGVGRPU0tZ?=
 =?utf-8?B?TTNBb29ScWUxQ05Bdlk2R29GcVZ5elZTOFFBU3haUW11VHR6Smt2aGcvdTZq?=
 =?utf-8?B?bFhLeUdrdG03Z001cnlXeHVwTnRUckNlSXFiSVpuc0wyWUZZYVovYmh6bksv?=
 =?utf-8?B?akJMWVlMQi9LN3pxZnp2MXFTTU9GNklhS1JCb01HWmJabkl0SlkrZytoSkFN?=
 =?utf-8?B?clhEQ2M1b1YvZXRJRWhjMEF1N29YZUlpT2xzVnJObTgxdG5va1Y2bzhGQTcx?=
 =?utf-8?B?UGp3Z1JtYUt3cGNQMkdWRDhpOXV5U1RmclRZWExyMmJ1ZzhwMk83MjUzQW5Q?=
 =?utf-8?B?aHc1ZHBrcENWWk1TN09Ja2RFa1dmdSs2UEttdHNLNmQzSmZTMC92cmtTUXNE?=
 =?utf-8?B?VGt2NzNBUldQeCtSZVFyUmpGWVQ5SUprZHp0SVlRbzlzTTEweHFUYnRrL2FV?=
 =?utf-8?B?NnZ1bFZTemNPOVN6TWNzbzFxR3NLalh4bHRrMW83a0xycWoyQ3oycURTRnJK?=
 =?utf-8?B?MEQ4ZjVQMWRzTkJWWG4vcDU0NVpITnpVMFZXVExBMzJrbE1rMURrbnY3alBJ?=
 =?utf-8?B?ZUxPS3RjdGZLQUtoaVlNdERJY3FyWWRDdUF6a2hBMzlyTW9lV1lhYXFMZEFU?=
 =?utf-8?B?NzdHQVd1cXp2UHdZdWFZdVF3NXVrS0JVU0NFTDhNNDN2NTRtWU1EQ3ZERm1E?=
 =?utf-8?B?L2V2ZTlkSDNnS3RVRkpaeU5CdDdtd2pDTXhTVWVFSVRTZXNhaE1Gazc3Qk9r?=
 =?utf-8?B?Ymg0c3BmcitvZUczN29YRmx4bFB4cVduWVBOYkZUWnNpQzBPV1ZzY0RCZ3NZ?=
 =?utf-8?B?c3d1VVRvcVp1OHUzWWQwYWhISU9nYmJTVzlGK0JNdWQ2dlMrdGV3UTVFblhD?=
 =?utf-8?Q?F33Q7rWfeqSogI3VKCvKikuMH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB0943.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4429d415-ecba-4da7-04eb-08ddc484030c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 16:15:42.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqm+ihtab/Imd/2xdbPgfsJVYy6pEswT87WhYA+NvbxKSqhpSlDznQH9Rc+VRXNKbNpx7Ag0xcebG7fYExaRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2017

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWGluIExvbmcgPGx1Y2ll
bi54aW5AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTYsIDIwMjUgMTE6MTQg
QU0NCj4gVG86IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gQ2M6IExpIFRpYW4g
PGxpdGlhbkByZWRoYXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGh5
cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEhhaXlh
bmcgWmhhbmcNCj4gPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBEZXh1YW4gQ3VpIDxkZWN1aUBt
aWNyb3NvZnQuY29tPjsgU3RlcGhlbg0KPiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1i
ZXIub3JnPjsgTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+IFN1YmplY3Q6IFtFWFRF
Uk5BTF0gUmU6IFtQQVRDSCB2M10gaHZfbmV0dnNjOiBTZXQgVkYgcHJpdl9mbGFncyB0bw0KPiBJ
RkZfTk9fQUREUkNPTkYgYmVmb3JlIG9wZW4gdG8gcHJldmVudCBJUHY2IGFkZHJjb25mDQo+DQo+
IE9uIFdlZCwgSnVsIDE2LCAyMDI1IGF0IDU6MjnigK9BTSBTaW1vbiBIb3JtYW4gPGhvcm1zQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gKyBYaW4gTG9uZw0KPiA+DQo+IFRoYW5rcyBmb3Ig
Q2NpbmcgbWUuDQo+DQo+ID4gT24gV2VkLCBKdWwgMTYsIDIwMjUgYXQgMDg6MjY6MDVBTSArMDgw
MCwgTGkgVGlhbiB3cm90ZToNCj4gPiA+IFNldCBhbiBhZGRpdGlvbmFsIGZsYWcgSUZGX05PX0FE
RFJDT05GIHRvIHByZXZlbnQgaXB2NiBhZGRyY29uZi4NCj4gPiA+DQo+ID4gPiBDb21taXQgdW5k
ZXIgRml4ZXMgYWRkZWQgYSBuZXcgZmxhZyBjaGFuZ2UgdGhhdCB3YXMgbm90IG1hZGUNCj4gPiA+
IHRvIGh2X25ldHZzYyByZXN1bHRpbmcgaW4gdGhlIFZGIGJlaW5nIGFzc2luZ2VkIGFuIElQdjYu
DQo+ID4gPg0KPiA+ID4gRml4ZXM6IDhhMzIxY2Y3YmVjYyAoIm5ldDogYWRkIElGRl9OT19BRERS
Q09ORiBhbmQgdXNlIGl0IGluIGJvbmRpbmcNCj4gdG8gcHJldmVudCBpcHY2IGFkZHJjb25mIikN
Cj4gPiA+IFN1Z2dlc3RlZC1ieTogQ2F0aHkgQXZlcnkgPGNhdmVyeUByZWRoYXQuY29tPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogTGkgVGlhbiA8bGl0aWFuQHJlZGhhdC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+IHYzOg0KPiA+ID4gICAtIG9ubHkgZml4ZXMgY29tbWl0IG1lc3NhZ2UuDQo+ID4gPiB2
MjoNCj4gaHR0cHM6Ly9sb3JlLmtlci8NCj4gbmVsLm9yZyUyRm5ldGRldiUyRjIwMjUwNzEwMDI0
NjAzLjEwMTYyLTEtDQo+IGxpdGlhbiU0MHJlZGhhdC5jb20lMkYmZGF0YT0wNSU3QzAyJTdDaGFp
eWFuZ3olNDBtaWNyb3NvZnQuY29tJTdDODA0ODU5NDhjDQo+IGIzNDRiMTJmMmRkMDhkZGM0N2I3
YzZlJTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzODg4DQo+
IDI3NTY4NjgyNDkzMTMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9u
UnlkV1VzSWxZaU9pSXdMakF1DQo+IE1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdG
cGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0DQo+IGE9MWxqV0lGdG5oQWlH
amRJRWdOTmxRWkdLJTJGJTJGWkhkZ0hWa3Z5Q1dZOSUyQkt4SSUzRCZyZXNlcnZlZD0wDQo+ID4g
PiAgIC0gaW5zdGVhZCBvZiByZXBsYWNpbmcgZmxhZywgYWRkIGl0Lg0KPiA+ID4gdjE6DQo+IGh0
dHBzOi8vbG9yZS5rZXIvDQo+IG5lbC5vcmclMkZuZXRkZXYlMkYyMDI1MDcxMDAyNDYwMy4xMDE2
Mi0xLQ0KPiBsaXRpYW4lNDByZWRoYXQuY29tJTJGJmRhdGE9MDUlN0MwMiU3Q2hhaXlhbmd6JTQw
bWljcm9zb2Z0LmNvbSU3QzgwNDg1OTQ4Yw0KPiBiMzQ0YjEyZjJkZDA4ZGRjNDdiN2M2ZSU3Qzcy
Zjk4OGJmODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2Mzg4OA0KPiAyNzU2ODY4
MjcyMzgxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0ls
WWlPaUl3TGpBdQ0KPiBNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxk
VUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdA0KPiBhPW8lMkIyQk05WUVpM08yemNxUXU5
S2ZQYWU2UFplckJXTyUyRmhMNUtDSWVKOXhJJTNEJnJlc2VydmVkPTANCj4gPiA+IC0tLQ0KPiA+
ID4gIGRyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2NfZHJ2LmMgfCA1ICsrKystDQo+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gSGkg
TGkgVGlhbiwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgYWRkcmVzc2luZyBlYXJsaWVyIGZlZWRiYWNr
Lg0KPiA+DQo+ID4gSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byByZXBvc3QgYmVjYXVzZSBvZiB0
aGlzLCBidXQgZm9yIGZ1dHVyZQ0KPiByZWZlcmVuY2U6DQo+ID4NCj4gPiAxLiBCZWNhdXNlIHRo
aXMgaXMgYSBmaXggZm9yIGEgY29tbWl0IHRoYXQgaXMgcHJlc2VudCBpbiBuZXQNCj4gPiAgICBp
dCBzaG91bGQgYmUgdGFyZ2V0ZWQgYXQgdGhhdCB0cmVlLg0KPiA+DQo+ID4gICAgU3ViamVjdDog
W1BBVENIIG5ldCB2WF0gLi4uDQo+ID4NCj4gPiAyLiBQbGVhc2UgdXNlIGdldF9tYWludGFpbmVy
cy5wbCB0aGlzLnBhdGNoIHRvIGdlbmVyYXRlIHRoZSBDQyBsaXN0LiBJbg0KPiA+ICAgIHRoaXMg
Y2FzZSBYaW4gTG9uZyAobm93IENDZWQpIHNob3VsZCBiZSBpbmNsdWRlZCBhcyBoZSBpcyB0aGUg
YXV0aG9yDQo+IG9mIHRoZQ0KPiA+ICAgIHBhdGNoIGNpdGVkIGluIHRoZSBGaXhlcyB0YWcuDQo+
ID4NCj4gPiAgICBiNCBjYW4gaGVscCB5b3Ugd2l0aCB0aGlzIGFuZCBvdGhlciBhc3BlY3RzIG9m
IHBhdGNoIG1hbmFnZW1lbnQuDQo+ID4NCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvaHlwZXJ2L25ldHZzY19kcnYuYw0KPiBiL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2Nf
ZHJ2LmMNCj4gPiA+IGluZGV4IGM0MWEwMjVjNjZmMC4uOGJlOWJjZTY2YTRlIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9uZXQvaHlwZXJ2L25ldHZzY19kcnYuYw0KPiA+ID4gKysrIGIvZHJp
dmVycy9uZXQvaHlwZXJ2L25ldHZzY19kcnYuYw0KPiA+ID4gQEAgLTIzMTcsOCArMjMxNywxMSBA
QCBzdGF0aWMgaW50IG5ldHZzY19wcmVwYXJlX2JvbmRpbmcoc3RydWN0DQo+IG5ldF9kZXZpY2Ug
KnZmX25ldGRldikNCj4gPiA+ICAgICAgIGlmICghbmRldikNCj4gPiA+ICAgICAgICAgICAgICAg
cmV0dXJuIE5PVElGWV9ET05FOw0KPiA+ID4NCj4gPiA+IC0gICAgIC8qIHNldCBzbGF2ZSBmbGFn
IGJlZm9yZSBvcGVuIHRvIHByZXZlbnQgSVB2NiBhZGRyY29uZiAqLw0KPiA+ID4gKyAgICAgLyog
U2V0IHNsYXZlIGZsYWcgYW5kIG5vIGFkZHJjb25mIGZsYWcgYmVmb3JlIG9wZW4NCj4gPiA+ICsg
ICAgICAqIHRvIHByZXZlbnQgSVB2NiBhZGRyY29uZi4NCj4gPiA+ICsgICAgICAqLw0KPiA+ID4g
ICAgICAgdmZfbmV0ZGV2LT5mbGFncyB8PSBJRkZfU0xBVkU7DQo+ID4gPiArICAgICB2Zl9uZXRk
ZXYtPnByaXZfZmxhZ3MgfD0gSUZGX05PX0FERFJDT05GOw0KPiBJZiBpdCBpcyBvbmx5IHRvIHBy
ZXZlbnQgSVB2NiBhZGRyY29uZiwgSSB0aGluayB5b3UgY2FuIHJlcGxhY2UgSUZGX1NMQVZFDQo+
IHdpdGggSUZGX05PX0FERFJDT05GLg0KPg0KPiBJRkZfU0xBVkUgbm9ybWFsbHkgY29tZXMgd2l0
aCBJRkZfTUFTVEVSLCBsaWtlIGJvbmRpbmcgYW5kIGVxbC4NCj4gSSBkb24ndCBzZWUgSUZGX01B
U1RFUiB1c2VkIGluIG5ldHZzY19kcnYuYywgc28gSUZGX1NMQVZFIHByb2JhYmx5DQo+IHNob3Vs
ZCBiZSBkcm9wcGVkLCBpbmNsdWRpbmcgdGhlIG9uZSBpbiBfX25ldHZzY192Zl9zZXR1cCgpPw0K
DQpUaGUgSUZGX1NMQVZFIGlzIG5vdCBqdXN0IGZvciBpcHY2LCB0aGUgY29tbWVudCBzaG91bGQg
YmUgdXBkYXRlZC4NCklGRl9TTEFWRSBpcyBhbHNvIHVzZWQgYnkgdWRldiBhbmQgb3VyIG90aGVy
IHVzZXIgbW9kZSBkYWVtb25zLCBzbyBpdCBuZWVkcw0KdG8gc3RheS4NCg0KLSBIYWl5YW5nDQoN
Cg==

