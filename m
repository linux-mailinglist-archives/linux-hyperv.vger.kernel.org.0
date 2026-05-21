Return-Path: <linux-hyperv+bounces-11133-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI8YEDU1D2qSHgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11133-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:39:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A15A9707
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D76832E9263
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A945B2F1FDE;
	Thu, 21 May 2026 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lhKMnb23"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010027.outbound.protection.outlook.com [52.103.23.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA1349CCF;
	Thu, 21 May 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378345; cv=fail; b=GR1gIMLWZ6qhEOQHBiVUqWpTaHqzU69T1ubrqAiswm0/JGS2rWH9BkcXiiIpQL/Q8q8pz9ZjDStLcutna5R1mLLfRq+7FDWfqspNdI73SwVfAHlTwQn77IfFYZeL54h0+j8lyGNOiHdyBnVir+TxWdBY4zgit8leHZd+WP9Z9+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378345; c=relaxed/simple;
	bh=TRdZERGugo57kIPiQuosNgmgTD2iO9UFcGbiz/zMxcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cCt50zpHgMBV2U2PsEr92wzp1V8R/2IHj/2ne4hbzJPxio2yTIHjyvQ3ZCew00JOztiN4VxiF1JQSHgV5xpM+4Uhib0nVjU3AUkNOou1LjD+ou7R8MoLp5tKbDCkknQylPf1bfpqTgY9gW7y243mT7cJi6mU1hnEJoHmIyb4ouE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lhKMnb23; arc=fail smtp.client-ip=52.103.23.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTpdsJmPUcIoK8gnCJmWgchw52Ac+Y4ALqZ+eEKgX73lWXky3DzzgGilaFY7q97+/H+b4tJF25+Wm9+Y2s8ZoKYw8D0aENTBvdm4cs25bRZvEPMEuG1wbSlpK+p7fhGDP79WluQPniqzkX+gr15b8RTp9Cl5or7Xy3ctv92QQJ2omCPbLR6mCoVjkLpQf36wUafwK4fDZsse4wcAEZtQnXYkv2zXff6G1XAnVjueVMdF8yx0TzDpEzSWKr9vsFi1feTViZWnb5M2r0ZP6Ta+Z5NS/e8lfN8NNJoJOgmGlaiQKdGBT/nHvQDd+hLd8vG+PtVmOTrjqKGZP2JWy04C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRdZERGugo57kIPiQuosNgmgTD2iO9UFcGbiz/zMxcs=;
 b=O/ag2lUxWLTlA2JBDb1qCkaMqDBH+esxsc4jEtujfMara8mXQKN0L97hzmylpwEG20F/DKtO7DVpJB4S4xMLOFOyX0JPiSOGxlP0kzZoK2vQWOexaH6O0fIbMjCd+51T2awZcUFZ2pk1w8DliBA2WO4S6zCZu51lhEgWRtv/+KpuH/KkW5jMM8ZRi/yPNHeooIYZ6FTAHHmXR22dwE2vZoB4Na7U/2rZf2fWnZBovA/Jq0ivJd+PM5MFShXswX0PM78MFvO44EciScd+X419rLV60ZCbIbhp0dFA7KhHxKsUnjDL2OH5EnA16fsodnx69j46ZTY0B30mw0kyTPX4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRdZERGugo57kIPiQuosNgmgTD2iO9UFcGbiz/zMxcs=;
 b=lhKMnb23W/NNrMDrzTYgwZqiSAOmRr4aKf3FsKd02ijgjMJt88ZjtWkWBZtcAf/UqRx8mdYwbeJFpOcE+aYv3V6aENiz4SDZExxYZyy9zjkXHY7LuasLQFhosx09p69MORwtRx50lLYsaprM5AfH9Gr/EAwwXuxG7k1cCwiP9vjKQc7mAMFkpG6MWbf0waWiFe7FRm/6xzU3DfP/FgaxVAoWuDkKOddYibCuXiVaMsSoDyI3G508XFX75UioHmDRjdYSSDM6rYh7GcVvWH/A3QdhbGpOlXeo/w+wtq2o6Nw1EFjPEkl0H7LswVk3tl4Kw2d23pggtpdQ6tECvPJpkw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LVXPR02MB11460.namprd02.prod.outlook.com (2603:10b6:408:388::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 15:45:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:45:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: Yu Zhang <zhangyu1@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index:
 AQJDuACGb2SFxAgG/WSEtOdKOL4HjAGk+UcvAojevN21KBm8AIAAHqSwgAAapoCAAT/3UA==
Date: Thu, 21 May 2026 15:45:40 +0000
Message-ID:
 <SN6PR02MB41576B83C1C5E613998FAB2CD40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
	<20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
	<20260515223545.GL7702@ziepe.ca>
	<lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
	<SN6PR02MB4157C1EC7F5F69C5ABDA9C7FD4012@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260520134027.00005e91@linux.microsoft.com>
In-Reply-To: <20260520134027.00005e91@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LVXPR02MB11460:EE_
x-ms-office365-filtering-correlation-id: dbf71abe-05a4-46b0-fa27-08deb75002f5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|37011999003|41001999006|19110799012|8062599012|51005399006|13091999003|19101099003|31061999003|15080799012|440099028|3412199025|12091999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1Z5d29HcE5CRVJHR1dSM2N4NTdXNys0YjIxeGllbXhkVzJwRU5HUU5JVkV4?=
 =?utf-8?B?Z3JBV1djOTlSYnJaN0txek4zQXBGWmNpaVVWbVhCMGVzMnVUZXpnNzBoTWVY?=
 =?utf-8?B?ZVJZRk1oMG5kMURQSGF5eGV3QldXSFdzNnhyQytmM21sdjk0Ungwb0Rla0N1?=
 =?utf-8?B?c1d6bW9KZHFmQWd4YmJNa1hhTDUvWmVqQWFLdzFHcWsvSStpbDVRRWNrWGpJ?=
 =?utf-8?B?eEkzNlJKa21PYzZoWi90d0puSCttMTR0NDRZWXBla1BaMjlNZEswZk12MlZt?=
 =?utf-8?B?RFBLcCt1Q3FKcUljMEkvZ3p2K1JhN0l0RnkraU90ZU42bXJkZXZBNGpNU3l1?=
 =?utf-8?B?ZUNacHBLTWZwRzdFMVQ5QnovSDQ4TjIrWDFkdm14VDZkbHhiY1ZlZUQxSEIr?=
 =?utf-8?B?QW8wdjdkekRNeE1rK3ljbGIvZWlQd2NqNzQ1UU80RWt6U0lEWnlySFRDYytK?=
 =?utf-8?B?T1QyeFp2ZUdKa0NtVk9yZUZNZmREKzNNVElmamErUlNnWEFFNSs1Wk9IRGRM?=
 =?utf-8?B?bXBWalVIMEo5RlY2d0tpUnpFMDJEUkNFTHg5eW1CU2RnTFVMUWxvd1FxMDRY?=
 =?utf-8?B?TGZWV1Q2UHg5Rmc2bEZQc1hpbm9DN0ZPL1VLSHFlUWFDSWlYZVAvOW5CR0Rx?=
 =?utf-8?B?eDkzRE1tUVo1bUxIcFFUV3laTWFiK1RRMUE2QnlXNDlWZWtWcGdhVVV5Z0dh?=
 =?utf-8?B?Uys2WnRBcTVITk5sV1ZDUGpIRHJTOVZkbEhJcHg2MHJxbXpWUmRFaHNaSHgy?=
 =?utf-8?B?THdpeWVIUURIK01OajFPMllqd2I2WTQ4YVEveEJSc1I2eElYSWJjOTQzMUMy?=
 =?utf-8?B?ZDdHRTBsS084Mno0VXIrVk9IMTA2VklmYUYwTzVUbjFYSEoxbFJDODFCazRB?=
 =?utf-8?B?QkZJYkFRbUc2WkRrT05vSkJFYmo2U2lIWkhLUkk5RU8wWVZDcFVKd3QvbWpv?=
 =?utf-8?B?bWw1ZnRlcmozMUZ1TUlJRE9EUXBZdkh1bUJMMEcrb3dranpIaEgyTk8zTmVI?=
 =?utf-8?B?dkR4MEQ3QlZQWDIwQnVQN2lHd2tqbzk0SkZMNHBvdlc1Tkx1LzRnbEEwODd1?=
 =?utf-8?B?VkVCVXRhbTlkUjlKMWl6eHA4Z3B2VzR5eDN5b1BScDZvVHhBdHd6bzZYbmcv?=
 =?utf-8?B?OFhJK0JwK01hbG5zM2FoV0Yzbk14UjNBRzlhc205Z1dJNU5UQUJsSnRncHM4?=
 =?utf-8?B?OVFPVEdYK1ExeklTd0FraWxQNFhJWE1wY3I3Z0hWWExneHI5Ykx5SU0xMk9P?=
 =?utf-8?B?Q05YR0Y1WUpRZEtIeTlUTDdrUFlvb2t6TjBZZkMwRm02eFhDaGFRNzIyVkYy?=
 =?utf-8?B?bEVZQ3A4RkpGUGtocjJFNXFnRGRHUkRlcWg1YStXZkpJMGJVcVE2V2VQaWhR?=
 =?utf-8?B?NWN1TmcySGJGY29hc1UwSUlCY2FoM3QrNjZ3VW5NK0lyM0xUL2s1dDNTNjlt?=
 =?utf-8?B?NWtNd3FmQTFtU1BHRHhjNitEN0tzYStkMXQ3c2lBPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGpwNHg3K1IreHQ1OTMrZyszaWtrSmdIdHRLM0FReVFDYjFNVTgrdUZjOVVB?=
 =?utf-8?B?Um1MNWpWU1ZsR3liTS9VdHZqN1BkNDBqM1JyYkJ2Tjl2WEw2Sjk3UVRIN2Nl?=
 =?utf-8?B?M1pGWnQrekFoMk51Y2JsSXovY1pSLzZzLyt4ZGdzU3RUWEtocHVGdk5sNEl6?=
 =?utf-8?B?a01xMEtqTzRWQWllZkRrUk80OVhhZnZ6czVZMElIVUVQSTVyNnIzQ0pPU3lD?=
 =?utf-8?B?Sy9pWkx3ZGVnWjRWRTVxazBZb2lvSFlJTVBvMkRmTDhZMHNkSUZJamdyU05R?=
 =?utf-8?B?QnlYOEQ1M3grQyt5cWRSOGVMUndRbm1sNXdqMGRHamN0K3NyeUdZMXVjLzJM?=
 =?utf-8?B?WmEzQnp4eXU4TFZHVURSb2FmbDdiL3RoekZCNjBITitxTlR0eFVYYkw4Rk9k?=
 =?utf-8?B?eUNFWGFpdDdWVThvVHRYY2JYdmdEZGdsMmh6bHJwK3FqZGI1aUxJbUZDSmp6?=
 =?utf-8?B?U2oyWmZIUWRGU3UyZEJLZmd5WjlBOU4zVXBLSER1bnNkRmdoOFhCSXQwUTdq?=
 =?utf-8?B?OHFxSEl6THNmMjhvVm1WTVhJRmxUdkxHODIrM1Nrbm9uZ3huYVNocnl1T1VY?=
 =?utf-8?B?Ui85bHVNSDNqTVRjZk9uMGFPSGxPdloyYkhONWxONVdWVmN2Ym9UZHJYNjlk?=
 =?utf-8?B?QkNWbDZIL0xsN3RPMGtwOWhDME5QZXZMQVFSSW1ObEFyOGdScjVsajNMWkR5?=
 =?utf-8?B?dG5GVGFJVm52ODhMcWJtNkV0d3hTR1A0WE0rTkYzYzJxd2I3SjB6Vm1sT09C?=
 =?utf-8?B?Sk1sbUcwam44bVBhbFp0d2dlL0FIM1V0NHo3NUZLSklvOVNRZDJPY3RON2Vu?=
 =?utf-8?B?QTdTTzNEaVVrdWFDa2daZ0VNMWJCb0pIU08ycFg0ZnVPbk96NkZ2YVlNRzlL?=
 =?utf-8?B?bHNjZkhZOWdlU2NPbldUcU5YclIyRjVpTUEwSVN1SDJ2WWwyUXEwSEpPR0Fh?=
 =?utf-8?B?cDZlbktwdWx2UlZIbG1iTk1CTU9CTm1kejY2ZTNpVkEzNVREQjYxTldLWjJF?=
 =?utf-8?B?NmFBUGFyaFhYeUNCcHJLMGRJaDIxNk4xREMxTnZXMW1wMHZmb2tma3g3Y3VQ?=
 =?utf-8?B?c2lJd09mN2p5NjRCYWdJWjdyYUVnc0QwT1RVYXpuR09HRTMzV0s2NjdNVXJX?=
 =?utf-8?B?T1ptNXBpN2c1bjA2RVZZYU1JOVpwWUpGb3dyOVlVTVdTTmJzM2tYOU14cFBu?=
 =?utf-8?B?RHkvK0l4VDRiMjFGYXdneE54Zk0wblBxME10QXdySUhhbXlZWnE5cXlwaW1E?=
 =?utf-8?B?akVPRkpKRGFjR1d0RHFodUNmVDlWcm5RblZCUjRxZXBDY092OFB2SXFPdHVy?=
 =?utf-8?B?TjlqSS90Wk54TEV0VUwwKzVRdUFxazRraVc3QnNrcWhMOTE4eXJvNWxTbG5U?=
 =?utf-8?B?bzMxQjExM2o0SjNLcUZXZ3dnTFBKdUdDWFlBaVUyWDZzWUhLOE42R3hRdXpx?=
 =?utf-8?B?Z21EMSszRmltUDM4aC9Cc0habzNxZ2J0cEUyQ3NuQzVtYVptWnFFWnNtS3Rr?=
 =?utf-8?B?Y1BnMzVsYURSRDhKcmpBaHJmM1VKZndZSm9TcEo3NjRlVzhxaUhPcTFlT1BF?=
 =?utf-8?B?OExBR2pma0xrd04rSFhmaHFyTVlobjZDbTBHMG1pb2JBMHkvdm5jQlB1eWZP?=
 =?utf-8?B?ZmdUSWhZYW0rUGE1dnl2S0o5ZU81NDNBYkxkN2F2YWpLeEVjQ1p5K3JUUXRK?=
 =?utf-8?B?bUszQkxpdE9lYnRMUmpnUHQxV2QrcnFsVFkvbVd5R09Uem1EdG1YR0Z1d2ZF?=
 =?utf-8?B?SEtGUEljSUtTa2VMTEdubnhYaVdiZDBONVBLNVlDNHlTNzRLaGdIZ3krS3Bt?=
 =?utf-8?Q?2NaSh1B7sShLENQuHdREGit5Yt631KK1S4YOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf71abe-05a4-46b0-fa27-08deb75002f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 15:45:40.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR02MB11460
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11133-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 834A15A9707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogSmFjb2IgUGFuIDxqYWNvYi5wYW5AbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogV2Vk
bmVzZGF5LCBNYXkgMjAsIDIwMjYgMTo0MCBQTQ0KPiANCj4gSGkgTWljaGFlbCwNCj4gDQo+IE9u
IFdlZCwgMjAgTWF5IDIwMjYgMTk6MjY6MjQgKzAwMDANCj4gTWljaGFlbCBLZWxsZXkgPG1oa2xp
bnV4QG91dGxvb2suY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTWljaGFlbCBLZWxsZXkgPG1o
a2xpbnV4QG91dGxvb2suY29tPiBUbzogWXUgWmhhbmcgPHpoYW5neXUxQGxpbnV4Lm1pY3Jvc29m
dC5jb20+LCBKYXNvbiBHdW50aG9ycGUNCj4gPg0KPiA+IEZyb206IFl1IFpoYW5nIDx6aGFuZ3l1
MUBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBXZWRuZXNkYXksIE1heSAyMCwgMjAyNiAxMDox
NSBBTQ0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTWF5IDE1LCAyMDI2IGF0IDA3OjM1OjQ1UE0gLTAz
MDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCBNYXkgMTIsIDIwMjYg
YXQgMTI6MjQ6MDhBTSArMDgwMCwgWXUgWmhhbmcgd3JvdGU6DQo+ID4gPiA+ID4gK3N0YXRpYyBp
bmxpbmUgdTE2IGh2X2lvbW11X2ZpbGxfaW92YV9saXN0KHVuaW9uDQo+ID4gPiA+ID4gaHZfaW9t
bXVfZmx1c2hfdmEgKmlvdmFfbGlzdCwNCj4gPiA+ID4gPiArCQkJCQkgIHVuc2lnbmVkIGxvbmcg
c3RhcnQsDQo+ID4gPiA+ID4gKwkJCQkJICB1bnNpZ25lZCBsb25nIGVuZCkNCj4gPiA+ID4gPiAr
ew0KPiA+ID4gPiA+ICsJdW5zaWduZWQgbG9uZyBzdGFydF9wZm4gPSBzdGFydCA+PiBQQUdFX1NI
SUZUOw0KPiA+ID4gPiA+ICsJdW5zaWduZWQgbG9uZyBlbmRfcGZuID0gUEFHRV9BTElHTihlbmQp
ID4+IFBBR0VfU0hJRlQ7DQo+ID4gPiA+ID4gKwl1bnNpZ25lZCBsb25nIG5yX3BhZ2VzID0gZW5k
X3BmbiAtIHN0YXJ0X3BmbjsNCj4gPiA+ID4gPiArCXUxNiBjb3VudCA9IDA7DQo+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ICsJd2hpbGUgKG5yX3BhZ2VzID4gMCkgew0KPiA+ID4gPiA+ICsJCXVuc2ln
bmVkIGxvbmcgZmx1c2hfcGFnZXM7DQo+ID4gPiA+ID4gKwkJaW50IG9yZGVyOw0KPiA+ID4gPiA+
ICsJCXVuc2lnbmVkIGxvbmcgcGZuX2FsaWduOw0KPiA+ID4gPiA+ICsJCXVuc2lnbmVkIGxvbmcg
c2l6ZV9hbGlnbjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwkJaWYgKGNvdW50ID49IEhWX0lP
TU1VX01BWF9GTFVTSF9WQV9DT1VOVCkgew0KPiA+ID4gPiA+ICsJCQljb3VudCA9IEhWX0lPTU1V
X0ZMVVNIX1ZBX09WRVJGTE9XOw0KPiA+ID4gPiA+ICsJCQlicmVhazsNCj4gPiA+ID4gPiArCQl9
DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJCWlmIChzdGFydF9wZm4pDQo+ID4gPiA+ID4gKwkJ
CXBmbl9hbGlnbiA9IF9fZmZzKHN0YXJ0X3Bmbik7DQo+ID4gPiA+ID4gKwkJZWxzZQ0KPiA+ID4g
PiA+ICsJCQlwZm5fYWxpZ24gPSBCSVRTX1BFUl9MT05HIC0gMTsNCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gKwkJc2l6ZV9hbGlnbiA9IF9fZmxzKG5yX3BhZ2VzKTsNCj4gPiA+ID4gPiArCQlvcmRl
ciA9IG1pbihwZm5fYWxpZ24sIHNpemVfYWxpZ24pOw0KPiA+ID4gPiA+ICsJCWlvdmFfbGlzdFtj
b3VudF0ucGFnZV9tYXNrX3NoaWZ0ID0gb3JkZXI7DQo+ID4gPiA+ID4gKwkJaW92YV9saXN0W2Nv
dW50XS5wYWdlX251bWJlciA9IHN0YXJ0X3BmbjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwkJ
Zmx1c2hfcGFnZXMgPSAxVUwgPDwgb3JkZXI7DQo+ID4gPiA+ID4gKwkJc3RhcnRfcGZuICs9IGZs
dXNoX3BhZ2VzOw0KPiA+ID4gPiA+ICsJCW5yX3BhZ2VzIC09IGZsdXNoX3BhZ2VzOw0KPiA+ID4g
PiA+ICsJCWNvdW50Kys7DQo+ID4gPiA+ID4gKwl9DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgc2Vl
bXMgbGlrZSBhIHJlYWxseSBzaWxseSBoeXBlcnZpc29yIGludGVyZmFjZS4gV2h5IGRvZXNuJ3QN
Cj4gPiA+ID4gaXQganVzdCBhY2NlcHQgYSBub3JtYWwgcmFuZ2U/IFNwbGl0dGluZyBpdCBpbnRv
IHBvd2VyIG9mIHR3bw0KPiA+ID4gPiBhbGlnbmVkIHJhbmdlcyBpcyB2ZXJ5IGluZWZmaWNpZW50
Lg0KPiA+ID4NCj4gPiA+IEZhaXIgcG9pbnQuIEknbSBub3Qgc3VyZSBob3cgbXVjaCBmbGV4aWJp
bGl0eSB3ZSBoYXZlIHRvIGNoYW5nZQ0KPiA+ID4gdGhpcyBoeXBlcmNhbGwgaW50ZXJmYWNlIGF0
IHRoZSBtb21lbnQgLSBpdCBwcmVkYXRlcyB0aGUgcHZJT01NVQ0KPiA+ID4gd29yayBhbmQgbWF5
IGhhdmUgb3RoZXIgY29uc3VtZXJzIGJleW9uZCBMaW51eCBndWVzdC4gT24gdGhlIG90aGVyDQo+
ID4gPiBoYW5kLCBoYXZpbmcgdGhlIGd1ZXN0IHNwZWNpZnkgMl5OLWFsaWduZWQgYmxvY2tzIGRv
ZXMgc2F2ZSB0aGUNCj4gPiA+IGh5cGVydmlzb3IgZnJvbSBoYXZpbmcgdG8gZGVjb21wb3NlIHJh
bmdlcyBpdHNlbGYgYmVmb3JlIGlzc3VpbmcNCj4gPiA+IGhhcmR3YXJlIGludmFsaWRhdGlvbiBj
b21tYW5kcyAtIHRoZSBndWVzdC1wcm92aWRlZCBlbnRyaWVzIGNhbiBiZQ0KPiA+ID4gZmVkIHRv
IHRoZSBIVyBtb3JlIG9yIGxlc3MgZGlyZWN0bHkuDQo+ID4gPg0KPiA+ID4gVGhhdCBzYWlkLCB0
aGUgd2F5IEknbSBjdXJyZW50bHkgdXNpbmcgdGhpcyBpbnRlcmZhY2UgbWF5IGJlDQo+ID4gPiBt
b3JlIHByZWNpc2UgdGhhbiBuZWNlc3NhcnkuIE1heWJlIHdlIGhhdmUgMiBvcHRpb25zOg0KPiA+
ID4NCj4gPiA+IDEpIEN1cnJlbnQgYXBwcm9hY2g6IGRlY29tcG9zZSB0aGUgcmFuZ2UgaW50byBt
dWx0aXBsZSBleGFjdA0KPiA+ID4gICAgMl5OLWFsaWduZWQgYmxvY2tzIHdpdGggbm8gb3Zlci1m
bHVzaCwgYnV0IGF0IHRoZSBjb3N0IG9mDQo+ID4gPiAgICBtb3JlIGNvbXBsZXggY2FsY3VsYXRp
b25zIGFuZCBtb3JlIGVudHJpZXMuDQo+ID4gPg0KPiA+ID4gMikgRm9sbG93IHdoYXQgSW50ZWwv
QU1EIGRyaXZlcnMgZG86IGZpbmQgYSBzaW5nbGUgbWluaW1hbA0KPiA+ID4gICAgMl5OLWFsaWdu
ZWQgYmxvY2sgdGhhdCBjb3ZlcnMgdGhlIGVudGlyZSByYW5nZSwgYnV0IG1heQ0KPiA+ID4gICAg
b3Zlci1mbHVzaC4NCj4gPiA+DQo+ID4gPiBBbnkgcHJlZmVyZW5jZT8NCj4gPiA+DQo+ID4gPiBA
TWljaGFlbCwgc2luY2UgeW91J3ZlIGFsc28gYmVlbiByZXZpZXdpbmcgdGhpcyBwYXRjaCwgSSdk
DQo+ID4gPiBhcHByZWNpYXRlIHlvdXIgdGhvdWdodHMgb24gdGhlIGFib3ZlIGFzIHdlbGwuIDop
DQo+ID4gPg0KPiA+DQo+ID4gSSdtIGp1c3QgZ3Vlc3NpbmcsIGJ1dCBwZXJoYXBzIGZsdXNoaW5n
IGFuIGFsaWduZWQgcG93ZXItb2YtMg0KPiA+IHJhbmdlIGNhbiBiZSBwcm9jZXNzZWQgYnkgdGhl
IGh5cGVydmlzb3IgYXQgYSByZWxhdGl2ZWx5IGZpeGVkDQo+ID4gY29zdCwgcmVnYXJkbGVzcyBv
ZiB0aGUgc2l6ZS4gSGF2aW5nIHRoZSBndWVzdCBkbyB0aGUgZGVjb21wb3NpbmcNCj4gPiBvZiBh
biBhcmJpdHJhcnkgcmFuZ2UgYWxsb3dzIHRoZSBoeXBlcnZpc29yIHRvIG1ha2UgdXNlIG9mIHRo
ZQ0KPiA+IGV4aXN0aW5nICJyZXAiIGh5cGVyY2FsbCBtZWNoYW5pc20gaWYgdGhlIGh5cGVyY2Fs
bCBpcyB0YWtpbmcNCj4gPiAidG9vIGxvbmciLiBUaGUgaHlwZXJ2aXNvciBjYW4gcGF1c2UgaXRz
IHByb2Nlc3NpbmcsIHJldHVybiB0bw0KPiA+IHRoZSBndWVzdCB0ZW1wb3JhcmlseSwgYW5kIHRo
ZW4gY29udGludWUgdGhlIGh5cGVyY2FsbC4gSWYgdGhlDQo+ID4gYXJiaXRyYXJ5IHJhbmdlIHdl
cmUgcGFzc2VkIGludG8gdGhlIGh5cGVyY2FsbCBmb3IgdGhlIGh5cGVydmlzb3INCj4gPiB0byBk
byB0aGUgZGVjb21wb3NpbmcsIHRoYXQgcGF1c2UtYW5kLXJlc3RhcnQgbWVjaGFuaXNtDQo+ID4g
d291bGRuJ3QgYmUgYXZhaWxhYmxlLg0KPiA+DQo+ID4gT2YgY291cnNlLCBMaW51eCBkb2Vzbid0
IHJlYWxseSB0YWtlIGFkdmFudGFnZSBvZiB0aGUgcGF1c2UgdG8NCj4gPiByZWR1Y2UgZ3Vlc3Qg
aW50ZXJydXB0IGxhdGVuY3kgYmVjYXVzZSB0aGUgSHlwZXItViBjb2RlIGluDQo+ID4gTGludXgg
dHlwaWNhbGx5IGRpc2FibGUgaW50ZXJydXB0cyBhcm91bmQgYSBoeXBlcmNhbGwgZHVlIHRvIHRo
ZQ0KPiA+IHdheSB0aGUgaHlwZXJjYWxsIGlucHV0IHBhZ2UgaXMgYWxsb2NhdGVkLiBCdXQgb3Ro
ZXIgZ3Vlc3QNCj4gPiBvcGVyYXRpbmcgc3lzdGVtcyBtaWdodCBiZW5lZml0IGZyb20gc3VjaCBh
IHBhdXNlLiBBbmQgd2UgY291bGQNCj4gPiBwcm9iYWJseSBmaXggdGhlIEh5cGVyLVYgY29kZSBp
biBMaW51eCB0byBhbGxvdyBpbnRlcnJ1cHRzIGR1cmluZyBhDQo+ID4gaHlwZXJjYWxsIHBhdXNl
L3Jlc3RhcnQgaWYgbG9uZy1ydW5uaW5nIGh5cGVyY2FsbHMgdHVybiBvdXQgdG8gYmUNCj4gPiBh
IHByb2JsZW0uDQoNCj4gSSBhbSBub3Qgc3VyZSBpZiB0aGlzIHBhdXNlIGZlYXR1cmUgaXMgc3Vp
dGFibGUgZm9yIElPVExCIGZsdXNoIGF0IGFsbA0KPiBzaW5jZSBpdCBpcyBpbmhlcmVudGx5IHN5
bmNocm9ub3VzIOKAlCB0aGUgY2FsbGVyIG11c3QgYmxvY2sgdW50aWwgYWxsDQo+IGludmFsaWRh
dGlvbnMgY29tcGxldGUuIFBhdXNpbmcgbWlkLWZsdXNoIHRvIHJldHVybiB0byB0aGUgZ3Vlc3QN
Cj4gZG9lc24ndCBoZWxwIGlmIHRoZSBndWVzdCBjYW4ndCBtYWtlIGZvcndhcmQgcHJvZ3Jlc3Mg
YW55d2F5Lg0KDQpJIGFncmVlIHRoYXQgaHlwZXJjYWxsIHBhdXNlL3Jlc3VtZSBkb2Vzbid0IGhl
bHAgd2l0aA0KZm9yd2FyZCBwcm9ncmVzcy4gQnV0IGl0IGNvdWxkIGhlbHAgd2l0aCBpbnRlcnJ1
cHQgbGF0ZW5jeSBpbiB0aGUNCmd1ZXN0IGlmIHRoZSBoeXBlcmNhbGwgZXhlY3V0ZXMgd2l0aCBp
bnRlcnJ1cHRzIGVuYWJsZWQgaW4gdGhlDQpndWVzdC4gRHVyaW5nIHRoZSBwYXVzZSB3aGVuIGNv
bnRyb2wgcmV0dXJucyB0byB0aGUgZ3Vlc3QsDQp0aGUgZ3Vlc3QgY291bGQgdGFrZSBhbiBpbnRl
cnJ1cHQsIHZlcnN1cyB0aGUgaW50ZXJydXB0IGhhdmluZw0KdG8gd2FpdCB1bnRpbCB0aGUgZW50
aXJlIGh5cGVyY2FsbCBjb21wbGV0ZXMuIEFuZCBpZiBwcmVlbXB0aW9uDQppcyBlbmFibGVkIGlu
IHRoZSBndWVzdCB0aHJlYWQgZXhlY3V0aW5nIHRoZSBoeXBlcmNhbGwsIHRoZSB0aHJlYWQNCmNv
dWxkIGJlIGRlc2NoZWR1bGVkLCBwb3RlbnRpYWxseSBpbXByb3Zpbmcgc2NoZWR1bGluZyBsYXRl
bmN5Lg0KDQpBdCBsZWFzdCB0aGF0J3MgbXkgdW5kZXJzdGFuZGluZyBvZiB3aHkgSHlwZXItViBo
YXMgdGhpcyBwYXVzZS8NCnJlc3VtZSBtZWNoYW5pc20gZm9yICJyZXAiIGh5cGVyY2FsbHMuIDot
KQ0KDQpNaWNoYWVsDQoNCg0KDQo=

