Return-Path: <linux-hyperv+bounces-3780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F2A20AC2
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 13:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6527A12BD
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3901A2393;
	Tue, 28 Jan 2025 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Qlj/hW6a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2119.outbound.protection.outlook.com [40.107.20.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9B19CCEC;
	Tue, 28 Jan 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068651; cv=fail; b=akVN8R1+qfygpbBexju6fjL9xnbS/NMaMCmaXHHLibnu59K+djZQFO0uLm8bK/ISvJOqew540TPfiJhg/NrEvfoNw/m7DT1uu0YCnfi49jsNuDIy5eP/C2bNq0KCdg8zilQ/Hg2jOZB78+ExzpOFyWAjcxKDb+wA+zm/D9fn6ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068651; c=relaxed/simple;
	bh=G4Onnm5TNZDtaT1eoOC8cYtnBD8ZGirJmxormfLGomg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=klrtn4FMPu25O8UlhOb7Z0aUUpPPv4KWuwAL/RXZSnG1SfajEEKyW2NMfp5f0Tb8CouSnQaYm7tXKI7adAG+OiDphxURc9kgpVHKW2pgmOkgQ2LeNPfefJ+gR50j8fkJFbiCIZUC2vGTj2guib72mVX/F4URMN+z4L3ykmeD1dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Qlj/hW6a; arc=fail smtp.client-ip=40.107.20.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuvFuu2xL9x/xyNXcn1wnQtSwJ9tCB0rECgm+k5cKX710B1X2aOSnmVbg6osx0a4WacYnvudz/uyo5JEDwk2Z0bs9KpP//cpXWM2ytPTzvzwbPoD1sfje/uo6zsMV70mIpzVY/Ys55MTrJyoEYnBEhZA/PTIOHe69px0bYPywEHvZGbNC1Hcpnkk2XNAYA1phRxGwx3E16ZfdrxWrU8AXblPhZWHcvfBZTFm9dFAmLYZVp9GzWMdT2dUcK0JUcJZF+PmuzkBTUBiu6pdPAvpveHKz+mKTqTp55iSEYvd+YSU0YzOGMI1IP4uJnrKvDwuzt8U2d6iEMfm/z4UVJYKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Onnm5TNZDtaT1eoOC8cYtnBD8ZGirJmxormfLGomg=;
 b=lWKqrzdnEbEm/50JcF94dlqCyuKLf3ANEgSh+NPd5i6hRyWss2x9qxHCTyiOiIh5wer9eyGhaSY9llgrKu35U5zd30xLvLaEuaIrZpCZYg7sLvaT07h7wiwOGy9KR6TPQ2tG8zoj48vwthzb9JlhPT4Y6rGh5gpwlk2IVngqj+WCvIWAft+QFnTMUhkbwxX+f/vAi4AsT5IBNjhllBcZJEOeUc8y5vE8J0B6nB0tZOI4DE12XNND09AcqE1jTOpv+N7KhiO11yNTivlYueRzTv0FwrtDjoNoVaW+/issFcNzUbySHVzdJNnjMpfGBAfcGMcJqhM10v1rmxdgTxJLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Onnm5TNZDtaT1eoOC8cYtnBD8ZGirJmxormfLGomg=;
 b=Qlj/hW6a6wOL1/ZZyZiDv+NzUt+KGE5RGRJhHgSD7f0CSF+dz25WkuvCoxMqgJUa6fCfGAo/4samEApmQ8bXkCdf9F/i/rxWzB2858T/D2/fabqGgkfr+y6MmVSHp06pV1fHMJ/IPSgh1L9fzUW5sgdYkRcqJUua+8dZN+4TLlA=
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com (2603:10a6:102:44c::19)
 by VI2PR83MB0742.EURPRD83.prod.outlook.com (2603:10a6:800:27e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.15; Tue, 28 Jan
 2025 12:50:45 +0000
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4]) by PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4%5]) with mapi id 15.20.8422.001; Tue, 28 Jan 2025
 12:50:45 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
Thread-Topic: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
Thread-Index: AQHba2CbIQPiU7G6YEOpUVe87HLYf7Mj2riAgAhUslA=
Date: Tue, 28 Jan 2025 12:50:45 +0000
Message-ID:
 <PA1PR83MB0662EFDF4BA2801C6D27D32EB4EF2@PA1PR83MB0662.EURPRD83.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-5-git-send-email-kotaranov@linux.microsoft.com>
 <SA6PR21MB4231B32163CE8420F572538ACEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To:
 <SA6PR21MB4231B32163CE8420F572538ACEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=883730d6-b699-4b62-82a9-2ffc22f6c14c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:34:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR83MB0662:EE_|VI2PR83MB0742:EE_
x-ms-office365-filtering-correlation-id: 950b8fad-f9ca-4e45-867f-08dd3f9a61d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkhRTCtoNWhPWDJuQ2tWazRGMENvM3p4SkxVNnRaTlpGN3lwbnp3ai9jL21n?=
 =?utf-8?B?YnNGck9udVY2Mi9mWkJqd09pUCtIUUw4aGk5WDhrNVdWR3hvN2F0YStVbFBn?=
 =?utf-8?B?ZEp4b2gyUy9JT0luNUFPU0d6aFdOZGI2WDI1K0JRaHFqRkhuZ0N3QVhjNUtM?=
 =?utf-8?B?cjIxMndxaktnMmVER0YvcDlEOUo2WURnYkFUMDVvOEc4bllLcndlNGw2STRn?=
 =?utf-8?B?bXQrU3hWZ1NjZ1FSdjgrOWxxUjRzclVuMGxRRVBFczBDazYxNWVHNlNSamtU?=
 =?utf-8?B?VkQwNmZHL01UNHNJRy9oNmlMZ0F3SDh0c21wRVc2UlhuNm5JMC81SGw2QWxT?=
 =?utf-8?B?U1lSMjU4N25GbXdJTUlCVHkzbUhub2dFWlQrd01vaGtSQlNKRURJRm5WeFUw?=
 =?utf-8?B?Z3lidHBwWUw0bjJJelJUUFMvUDdkT0NHeTZ0QmNpcnF3YSt4ck9wMnNlSk5h?=
 =?utf-8?B?d1phTU04Q01VMTFscjV6eG92RGpqZmJ3M1ZsR0tta2RrQ2Jmb21pRTcrczhl?=
 =?utf-8?B?NU5LRmgwRDFOeFBWYlpFTm9sV1JUWVVUVEpEazVybm9tYkxMTzBGYklMSlpG?=
 =?utf-8?B?bURycmZPemU3WTh6RFZyazN4ZG1namNCTFZnVzZnV25JQzcvckgvWTIybktP?=
 =?utf-8?B?QStHc2dBcjFIQ1loODdEbnlRNHVtNHl3OWtxeFBQQXUzMnhDa2t5U1hFcm5a?=
 =?utf-8?B?UHlxRDA3NmJCbFBiczhUU0w2UFk4TmVoWGlEWGUyekdnOEtsYkw5U2xEOG4v?=
 =?utf-8?B?MUN4em82NDNrT3dBOWlHRlZjWFR5MnVzR1N3dFZTN21xUjJSaEJtRWZHbVZM?=
 =?utf-8?B?Q0pXTXVTeFVTRHBKaUk4bHNpK09DcUl0VmxRYlltK2hFaFppN1c2aHIxdU1a?=
 =?utf-8?B?bU5QMEtOR2NVb1JMVUFUR21HZHd6NnhVVjVBNzlEKy9YUmxYN042VVQ3OXo3?=
 =?utf-8?B?TTArVzZLODdmODhUN2lKOFFRbEhkdm1XUDB4bjg0aWJmaTFYYTZIUGJ0ZU0w?=
 =?utf-8?B?YnZ6RlgvZVduWGNDdTMzaVRYY2tFbDMwMVJUS1QwVWhjdGlTdEJKbU9xdlhH?=
 =?utf-8?B?T1FHOFh1bzdQTm0ySWxTcC9EZGtNYS9GL1hFVTR2SVJnbDA4S1R5MjVXS0x6?=
 =?utf-8?B?Z1RPTCtHR1pjNlg1RExRZlE4aXpwRXNyNjVCdjZwbjVzYlF2V09pU2c1VjJW?=
 =?utf-8?B?RWxNZjdnQ3VPT1VmVnFUS1d2bEI4OUYyTkZ2KzA0NTloeEQvUEg2REVLd3Ar?=
 =?utf-8?B?a2ptejk4ODQySXhoYTc0dXJkWTdmUnhNTklSanNETXdIWXpWVzcrcXFzMWVT?=
 =?utf-8?B?WFVuZUJESUplMU8zenRoeW54NTBvT1VTLzBBRGpKc2h3WWJjd1l6SUVwUUZw?=
 =?utf-8?B?cmsyUU5UNEtGOEVhdmJJRS9uOTVlY1FpMDV2bnNFYmxXNlFmSHlFQ2t0ZTNP?=
 =?utf-8?B?dG4reEVBTlRkUGlBR2VlV2FhTldpSnJRUWkySlZvNThRZ1pMVTNOeXpTb2Jt?=
 =?utf-8?B?WDRDMDUzbXVuRUx5ZnVwNEtrZ3dtSGpNVWNOa2RKN01DeXlhS1ZpM1dvT2pE?=
 =?utf-8?B?V0N4a0RaZ0NwMGl3dUgzSzY4U0EwYVRRN21odE9LcjhucG10MUhneTVTUkNY?=
 =?utf-8?B?Mmc2TG9mRWVUL2EwZm14dGtDaDdmbnh0NkY4dFBaS0J6NmpjZG1BekNTaVFI?=
 =?utf-8?B?NFZ2bWNISWR2ZUtQQkpYK3NZeThUanUva1lRWUl3bU5wOVNjandkbTdsOEpI?=
 =?utf-8?B?em02dHh3Zi9JSHhZaGgrbENLNlJZNkRoZlVKRnNobnhId20wd3BUeTk5QUkr?=
 =?utf-8?B?RW01QVQ3RWJGcVFJb0pwdlVhYnhUdTRnRzVYSjBBRm9aTkVnays3SDVJalB2?=
 =?utf-8?B?eEZRYWkrcUdNdnlFUnQ3UlN6K09ib2E3T3R4cXR0SVZnZnZoK3FwV2xxd1lJ?=
 =?utf-8?Q?a03gzx7Yrt/rjo//bBkTG0lvuxUvH4EO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR83MB0662.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1AxVDl4VGVtT2hXV0ZtT2Z4dWNFU1gvMGszZjdFSXNPeXNMQ3dHOWNZL2w2?=
 =?utf-8?B?UGY5dXowVmNZRlhVV2FLdFhGTTBNdzQySVhCQStBMlVVQzl4cjZuVC9YSVlq?=
 =?utf-8?B?VmNHdlZza0NQRkxCS0NpbHR1clRFbmpqeE1qb2JqUVFXeFRaM00xUlVDc0NT?=
 =?utf-8?B?UzMvVHJTaUU5ejFTbWJrYWdGaURVamZBWVJxUGRSd2NSSHh5ZS9mS2FsOFlY?=
 =?utf-8?B?VWVEeUtSY1RYNzJ0dWJCTllYL3JzRFppSVhVOHB2eXIxR0xiZzdIWVBVaVhr?=
 =?utf-8?B?RjdVb2Rnb3NoNytsQ0pUR3pvWE0zUktGVHVGY2Y2NVlBdEV1RnRBSUlYcEwr?=
 =?utf-8?B?Z1F2Tm5iRndPL1VOVXBTamZDODl0bFRDQURNaE1vYlUwMmUrTW5OMXRBZlhx?=
 =?utf-8?B?WFhndXVZeU9DZjR5cGZFdkE5RVV1VVNzMUc5bEphSnRnL1hSWnB6ZFVqQkZl?=
 =?utf-8?B?QXhkb25Ya2pEM0I0SVJkK0IyTVZhMnlPbks4WXBQWkVjTXJYTzg3TjY5Ym41?=
 =?utf-8?B?ZllHbHBFSWNlRXhKd3VvUkNVNHF5RGdmV0syVlpHMmp6Mzh2WEJkYUMvcEp0?=
 =?utf-8?B?Yi9Kb2IrMmNQT1JyNTlYR3VyMWFtZUttd0ZlRFNXZnhBOXZ4eFptTkZPa3Yz?=
 =?utf-8?B?bGkxNkZDbFN0NS9GOFVRRjdhVktMWFBDcWhZWWp3d0d2YzFYNks4WGFMbVNQ?=
 =?utf-8?B?RnptWlZqbG4vcHNVOXVTK1I2NGZmUnNUWXhFT3pGK0gwWGpJV3pHYlBWQndh?=
 =?utf-8?B?VGYvZS90Snl4QWUrZ1IvQzNKbE9oQmR0VFNQQ3I4SlEzaWZ3eWowbzVwN0di?=
 =?utf-8?B?Y0c4bUpjSEVmaDBmUGlhMG1tamt3Vmkxa05tWFcvbkxCTDNndmtOd3lMSndk?=
 =?utf-8?B?SDdzb0ZacktTZklLV1ZYdmNPQmtTSUhnb3NNZHhQV0FtRmNSdkd2cFdkeGJI?=
 =?utf-8?B?cmhFT21hWWo2ZTYvM2Q4NzVTdTh2RXZUSGt2Nlg3VTM1c3lLZWlBTGlRTEtM?=
 =?utf-8?B?ZitqUWhGWVZBQW54TFArT0tueDdtNEswTWc5OCtuaVFtYU1DSWFUSExvelRk?=
 =?utf-8?B?REx5anc2K2lSa1Qza0FzV0JsTENJN0twK0cwcGcwTWJ2bWlybXpQSkVXTlBn?=
 =?utf-8?B?QmRkekFheFJHSDFxV2w5L01WeU1maWE4bHVPWERYOEVkc3ZLOFByQ3BOSE1a?=
 =?utf-8?B?ZmtORncycjhkYmlGQlhZbHUzU1kwKzdzcHRvYjIyN1kyVWU3c3Z5QTByMFVE?=
 =?utf-8?B?elNtUXlYOUo2cU9FTG1OR1B5RVZod1kzbDZIUTFtdTE0STFQTFVnNC9rTTNS?=
 =?utf-8?B?L1oySzNwUTJuYmJFK2ZOdEh5Rjk5VDZldUsxaVY4Mm9YYUZkVjVoclpCSlRF?=
 =?utf-8?B?eWNTL0ZqSVlCaFZFNld1eHlyOGdoV2FHNVFJcENyYzFUZGVmdTdUUWF4MXgv?=
 =?utf-8?B?ZjdLS1RJb1VHODVqeEg2dzV4bFp1UDdJcVVqdGFmRUl3RlBKRk8rOWd1V2FC?=
 =?utf-8?B?dGNHT3pEdnBha3ZUMlhMemp1NUMvWTNvR1l1NitMbHp2cXBxcGExZXlKaGds?=
 =?utf-8?B?OGI2QW8waXlZR3dsc3ZxL3FOM09NQTF0alN2a01manAvdkQxUE1jV2doTmNr?=
 =?utf-8?B?VU03WU9odFpvQjhZTXZwdmtwL2ozYUNIUWhCbmwzRkRvQ2l6VFF3cHVreGd0?=
 =?utf-8?B?KzhyUm94S0plcW1ISnJJeUVmbUtoTkI4ckplWU9MZTNyTElzNUgzZlRLelNu?=
 =?utf-8?B?VkxGa0tGUjJqaEovYWk2TVVuQ3ZGQVA0NFR3M1Y0UUF6d21hdnhjSlVXcXVH?=
 =?utf-8?B?V25VRklnVHRobUN3Z1FMbGgrRFo2OGRXbEQ0L2R3K01kYW02T0RkWHo3bzRz?=
 =?utf-8?B?YlR4c1d4UXd6eFBFb1BpY1F5RHJoOHl1V2VwV0ZPTmhWTUlDUkwrQ1ZQdTBj?=
 =?utf-8?B?bFVFbEx5aDRCbFYyeUR5d0hOVUprNm8yMnBJVTFxRGV0Yi9aWDFIZG54azJD?=
 =?utf-8?B?dThFM1BHVldHUkFheldTelRTZ09PenBBU05meTc4QWU0blNiZFdVZTFhblg4?=
 =?utf-8?B?TkIrQWdNY2FGWnZqUVYwZENDdVFubXFBVFlIVzFPOHJQeFBCdmsxL1QxWjds?=
 =?utf-8?Q?viYs7IMdbhOnQsKGJiJa/8fsO?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA1PR83MB0662.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950b8fad-f9ca-4e45-867f-08dd3f9a61d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 12:50:45.5201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7umnc1ePgSD9jdpoi+D7mv1XNrDLcWCqt32+CAIiRqcN/lJnNdlofdTzmXsXkp/aefl/lK5D3JMeKye2/BVUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR83MB0742

PiBTdWJqZWN0OiBSRTogW1BBVENIIHJkbWEtbmV4dCAwNC8xM10gUkRNQS9tYW5hX2liOiBjcmVh
dGUga2VybmVsLWxldmVsDQo+IENRcw0KPiANCj4gPiBTdWJqZWN0OiBbUEFUQ0ggcmRtYS1uZXh0
IDA0LzEzXSBSRE1BL21hbmFfaWI6IGNyZWF0ZSBrZXJuZWwtbGV2ZWwgQ1FzDQo+ID4NCj4gPiBG
cm9tOiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0KPiA+DQo+
ID4gSW1wbGVtZW50IGNyZWF0aW9uIG9mIENRcyBmb3IgdGhlIGtlcm5lbC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IFNoaXJheiBTYWxlZW0gPHNoaXJhenNhbGVlbUBtaWNyb3NvZnQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jIHwgODAN
Cj4gPiArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDUyIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gPiBiL2RyaXZlcnMvaW5maW5p
YmFuZC9ody9tYW5hL2NxLmMgaW5kZXggZjA0YTY3OS4uZDI2ZDgyZCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvY3EuYw0KPiA+IEBAIC0xNSw0MiArMTUsNTcgQEAgaW50IG1hbmFfaWJf
Y3JlYXRlX2NxKHN0cnVjdCBpYl9jcSAqaWJjcSwgY29uc3QNCj4gPiBzdHJ1Y3QgaWJfY3FfaW5p
dF9hdHRyICphdHRyLA0KPiA+ICAJc3RydWN0IGliX2RldmljZSAqaWJkZXYgPSBpYmNxLT5kZXZp
Y2U7DQo+ID4gIAlzdHJ1Y3QgbWFuYV9pYl9jcmVhdGVfY3EgdWNtZCA9IHt9Ow0KPiA+ICAJc3Ry
dWN0IG1hbmFfaWJfZGV2ICptZGV2Ow0KPiA+ICsJc3RydWN0IGdkbWFfY29udGV4dCAqZ2M7DQo+
ID4gIAlib29sIGlzX3JuaWNfY3E7DQo+ID4gIAl1MzIgZG9vcmJlbGw7DQo+ID4gKwl1MzIgYnVm
X3NpemU7DQo+ID4gIAlpbnQgZXJyOw0KPiA+DQo+ID4gIAltZGV2ID0gY29udGFpbmVyX29mKGli
ZGV2LCBzdHJ1Y3QgbWFuYV9pYl9kZXYsIGliX2Rldik7DQo+ID4gKwlnYyA9IG1kZXZfdG9fZ2Mo
bWRldik7DQo+ID4NCj4gPiAgCWNxLT5jb21wX3ZlY3RvciA9IGF0dHItPmNvbXBfdmVjdG9yICUg
aWJkZXYtPm51bV9jb21wX3ZlY3RvcnM7DQo+ID4gIAljcS0+Y3FfaGFuZGxlID0gSU5WQUxJRF9N
QU5BX0hBTkRMRTsNCj4gPg0KPiA+IC0JaWYgKHVkYXRhLT5pbmxlbiA8IG9mZnNldG9mKHN0cnVj
dCBtYW5hX2liX2NyZWF0ZV9jcSwgZmxhZ3MpKQ0KPiA+IC0JCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsJaWYgKHVkYXRhKSB7DQo+ID4gKwkJaWYgKHVkYXRhLT5pbmxlbiA8IG9mZnNldG9mKHN0cnVj
dCBtYW5hX2liX2NyZWF0ZV9jcSwgZmxhZ3MpKQ0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4g
Pg0KPiA+IC0JZXJyID0gaWJfY29weV9mcm9tX3VkYXRhKCZ1Y21kLCB1ZGF0YSwgbWluKHNpemVv
Zih1Y21kKSwgdWRhdGEtDQo+ID4gPmlubGVuKSk7DQo+ID4gLQlpZiAoZXJyKSB7DQo+ID4gLQkJ
aWJkZXZfZGJnKGliZGV2LA0KPiA+IC0JCQkgICJGYWlsZWQgdG8gY29weSBmcm9tIHVkYXRhIGZv
ciBjcmVhdGUgY3EsICVkXG4iLCBlcnIpOw0KPiA+IC0JCXJldHVybiBlcnI7DQo+ID4gLQl9DQo+
ID4gKwkJZXJyID0gaWJfY29weV9mcm9tX3VkYXRhKCZ1Y21kLCB1ZGF0YSwgbWluKHNpemVvZih1
Y21kKSwNCj4gPiB1ZGF0YS0+aW5sZW4pKTsNCj4gPiArCQlpZiAoZXJyKSB7DQo+ID4gKwkJCWli
ZGV2X2RiZyhpYmRldiwgIkZhaWxlZCB0byBjb3B5IGZyb20gdWRhdGEgZm9yIGNyZWF0ZQ0KPiA+
IGNxLCAlZFxuIiwgZXJyKTsNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4gPiArCQl9DQo+ID4NCj4g
PiAtCWlzX3JuaWNfY3EgPSAhISh1Y21kLmZsYWdzICYgTUFOQV9JQl9DUkVBVEVfUk5JQ19DUSk7
DQo+ID4gKwkJaXNfcm5pY19jcSA9ICEhKHVjbWQuZmxhZ3MgJiBNQU5BX0lCX0NSRUFURV9STklD
X0NRKTsNCj4gPg0KPiA+IC0JaWYgKCFpc19ybmljX2NxICYmIGF0dHItPmNxZSA+IG1kZXYtPmFk
YXB0ZXJfY2Fwcy5tYXhfcXBfd3IpIHsNCj4gPiAtCQlpYmRldl9kYmcoaWJkZXYsICJDUUUgJWQg
ZXhjZWVkaW5nIGxpbWl0XG4iLCBhdHRyLT5jcWUpOw0KPiA+IC0JCXJldHVybiAtRUlOVkFMOw0K
PiA+IC0JfQ0KPiA+ICsJCWlmICghaXNfcm5pY19jcSAmJiBhdHRyLT5jcWUgPiBtZGV2LQ0KPiA+
YWRhcHRlcl9jYXBzLm1heF9xcF93cikNCj4gPiB7DQo+ID4gKwkJCWliZGV2X2RiZyhpYmRldiwg
IkNRRSAlZCBleGNlZWRpbmcgbGltaXRcbiIsIGF0dHItDQo+ID5jcWUpOw0KPiA+ICsJCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArCQl9DQo+ID4NCj4gPiAtCWNxLT5jcWUgPSBhdHRyLT5jcWU7DQo+
ID4gLQllcnIgPSBtYW5hX2liX2NyZWF0ZV9xdWV1ZShtZGV2LCB1Y21kLmJ1Zl9hZGRyLCBjcS0+
Y3FlICoNCj4gPiBDT01QX0VOVFJZX1NJWkUsICZjcS0+cXVldWUpOw0KPiA+IC0JaWYgKGVycikg
ew0KPiA+IC0JCWliZGV2X2RiZyhpYmRldiwgIkZhaWxlZCB0byBjcmVhdGUgcXVldWUgZm9yIGNy
ZWF0ZSBjcSwgJWRcbiIsDQo+ID4gZXJyKTsNCj4gPiAtCQlyZXR1cm4gZXJyOw0KPiA+IC0JfQ0K
PiA+ICsJCWNxLT5jcWUgPSBhdHRyLT5jcWU7DQo+ID4gKwkJZXJyID0gbWFuYV9pYl9jcmVhdGVf
cXVldWUobWRldiwgdWNtZC5idWZfYWRkciwgY3EtPmNxZSAqDQo+ID4gQ09NUF9FTlRSWV9TSVpF
LA0KPiA+ICsJCQkJCSAgICZjcS0+cXVldWUpOw0KPiA+ICsJCWlmIChlcnIpIHsNCj4gPiArCQkJ
aWJkZXZfZGJnKGliZGV2LCAiRmFpbGVkIHRvIGNyZWF0ZSBxdWV1ZSBmb3IgY3JlYXRlDQo+ID4g
Y3EsICVkXG4iLCBlcnIpOw0KPiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+ICsJCX0NCj4gPg0KPiA+
IC0JbWFuYV91Y29udGV4dCA9IHJkbWFfdWRhdGFfdG9fZHJ2X2NvbnRleHQodWRhdGEsIHN0cnVj
dA0KPiA+IG1hbmFfaWJfdWNvbnRleHQsDQo+ID4gLQkJCQkJCSAgaWJ1Y29udGV4dCk7DQo+ID4g
LQlkb29yYmVsbCA9IG1hbmFfdWNvbnRleHQtPmRvb3JiZWxsOw0KPiA+ICsJCW1hbmFfdWNvbnRl
eHQgPSByZG1hX3VkYXRhX3RvX2Rydl9jb250ZXh0KHVkYXRhLCBzdHJ1Y3QNCj4gPiBtYW5hX2li
X3Vjb250ZXh0LA0KPiA+ICsJCQkJCQkJICBpYnVjb250ZXh0KTsNCj4gPiArCQlkb29yYmVsbCA9
IG1hbmFfdWNvbnRleHQtPmRvb3JiZWxsOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlpc19ybmlj
X2NxID0gdHJ1ZTsNCj4gPiArCQlidWZfc2l6ZSA9IE1BTkFfUEFHRV9BTElHTihyb3VuZHVwX3Bv
d19vZl90d28oYXR0ci0NCj4gPmNxZQ0KPiA+ICogQ09NUF9FTlRSWV9TSVpFKSk7DQo+ID4gKwkJ
Y3EtPmNxZSA9IGJ1Zl9zaXplIC8gQ09NUF9FTlRSWV9TSVpFOw0KPiA+ICsJCWVyciA9IG1hbmFf
aWJfY3JlYXRlX2tlcm5lbF9xdWV1ZShtZGV2LCBidWZfc2l6ZSwNCj4gR0RNQV9DUSwNCj4gPiAm
Y3EtPnF1ZXVlKTsNCj4gPiArCQlpZiAoZXJyKSB7DQo+ID4gKwkJCWliZGV2X2RiZyhpYmRldiwg
IkZhaWxlZCB0byBjcmVhdGUga2VybmVsIHF1ZXVlIGZvcg0KPiA+IGNyZWF0ZSBjcSwgJWRcbiIs
IGVycik7DQo+ID4gKwkJCXJldHVybiBlcnI7DQo+ID4gKwkJfQ0KPiA+ICsJCWRvb3JiZWxsID0g
Z2MtPm1hbmFfaWIuZG9vcmJlbGw7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCWlmIChpc19ybmljX2Nx
KSB7DQo+ID4gIAkJZXJyID0gbWFuYV9pYl9nZF9jcmVhdGVfY3EobWRldiwgY3EsIGRvb3JiZWxs
KTsgQEAgLTY2LDExDQo+ID4gKzgxLDEzIEBAIGludCBtYW5hX2liX2NyZWF0ZV9jcShzdHJ1Y3Qg
aWJfY3EgKmliY3EsIGNvbnN0IHN0cnVjdA0KPiA+IGliX2NxX2luaXRfYXR0ciAqYXR0ciwNCj4g
PiAgCQl9DQo+ID4gIAl9DQo+ID4NCj4gPiAtCXJlc3AuY3FpZCA9IGNxLT5xdWV1ZS5pZDsNCj4g
PiAtCWVyciA9IGliX2NvcHlfdG9fdWRhdGEodWRhdGEsICZyZXNwLCBtaW4oc2l6ZW9mKHJlc3Ap
LCB1ZGF0YS0NCj4gPm91dGxlbikpOw0KPiA+IC0JaWYgKGVycikgew0KPiA+IC0JCWliZGV2X2Ri
ZygmbWRldi0+aWJfZGV2LCAiRmFpbGVkIHRvIGNvcHkgdG8gdWRhdGEsICVkXG4iLA0KPiBlcnIp
Ow0KPiA+IC0JCWdvdG8gZXJyX3JlbW92ZV9jcV9jYjsNCj4gPiArCWlmICh1ZGF0YSkgew0KPiA+
ICsJCXJlc3AuY3FpZCA9IGNxLT5xdWV1ZS5pZDsNCj4gPiArCQllcnIgPSBpYl9jb3B5X3RvX3Vk
YXRhKHVkYXRhLCAmcmVzcCwgbWluKHNpemVvZihyZXNwKSwNCj4gdWRhdGEtDQo+ID4gPm91dGxl
bikpOw0KPiA+ICsJCWlmIChlcnIpIHsNCj4gPiArCQkJaWJkZXZfZGJnKCZtZGV2LT5pYl9kZXYs
ICJGYWlsZWQgdG8gY29weSB0bw0KPiA+IHVkYXRhLCAlZFxuIiwgZXJyKTsNCj4gPiArCQkJZ290
byBlcnJfcmVtb3ZlX2NxX2NiOw0KPiA+ICsJCX0NCj4gPiAgCX0NCj4gPg0KPiA+ICAJcmV0dXJu
IDA7DQo+ID4gQEAgLTEyMiw3ICsxMzksMTAgQEAgaW50IG1hbmFfaWJfaW5zdGFsbF9jcV9jYihz
dHJ1Y3QgbWFuYV9pYl9kZXYNCj4gPiAqbWRldiwgc3RydWN0IG1hbmFfaWJfY3EgKmNxKQ0KPiA+
ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAJLyogQ3JlYXRlIENRIHRhYmxlIGVudHJ5ICovDQo+
ID4gIAlXQVJOX09OKGdjLT5jcV90YWJsZVtjcS0+cXVldWUuaWRdKTsNCj4gPiAtCWdkbWFfY3Eg
PSBremFsbG9jKHNpemVvZigqZ2RtYV9jcSksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKGNxLT5x
dWV1ZS5rbWVtKQ0KPiA+ICsJCWdkbWFfY3EgPSBjcS0+cXVldWUua21lbTsNCj4gPiArCWVsc2UN
Cj4gPiArCQlnZG1hX2NxID0ga3phbGxvYyhzaXplb2YoKmdkbWFfY3EpLCBHRlBfS0VSTkVMKTsN
Cj4gPiAgCWlmICghZ2RtYV9jcSkNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPg0KPiA+IEBA
IC0xNDEsNiArMTYxLDEwIEBAIHZvaWQgbWFuYV9pYl9yZW1vdmVfY3FfY2Ioc3RydWN0IG1hbmFf
aWJfZGV2DQo+ID4gKm1kZXYsIHN0cnVjdCBtYW5hX2liX2NxICpjcSkNCj4gPiAgCWlmIChjcS0+
cXVldWUuaWQgPj0gZ2MtPm1heF9udW1fY3FzIHx8IGNxLT5xdWV1ZS5pZCA9PQ0KPiA+IElOVkFM
SURfUVVFVUVfSUQpDQo+ID4gIAkJcmV0dXJuOw0KPiA+DQo+ID4gKwlpZiAoY3EtPnF1ZXVlLmtt
ZW0pDQo+ID4gKwkvKiBUaGVuIGl0IHdpbGwgYmUgY2xlYW5lZCBhbmQgcmVtb3ZlZCBieSB0aGUg
bWFuYSAqLw0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+IA0KPiBEbyB5b3UgbmVlZCB0byBjYWxs
ICJnYy0+Y3FfdGFibGVbY3EtPnF1ZXVlLmlkXSA9IE5VTEwiIGJlZm9yZSByZXR1cm4/DQoNCk5v
LiBIZXJlIEkgYXNzdW1lIG93bmVyc2hpcCBieSB0aGUgbWFuYS5rby4gU28sIGl0IHdpbGwgYmUg
bnVsbGVkIGJ5IG1hbmFfZ2RfZGVzdHJveV9jcSgpDQotS29uc3RhbnRpbg0KDQo+IA0KPiANCj4g
PiAgCWtmcmVlKGdjLT5jcV90YWJsZVtjcS0+cXVldWUuaWRdKTsNCj4gPiAgCWdjLT5jcV90YWJs
ZVtjcS0+cXVldWUuaWRdID0gTlVMTDsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi40My4wDQoNCg==

