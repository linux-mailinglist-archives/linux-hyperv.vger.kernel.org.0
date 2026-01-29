Return-Path: <linux-hyperv+bounces-8587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD4mNvice2nOGAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8587-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 18:46:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F35DBB32F9
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 18:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A28B30028E1
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5353559D2;
	Thu, 29 Jan 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AkFXgbG5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011038.outbound.protection.outlook.com [52.103.13.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38020311;
	Thu, 29 Jan 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708786; cv=fail; b=sB9NruvEmjX3gJXNJXKfrbF37MjWmRUkQW0pQYNhyDXRnCi9KcZoZ8srOChALvv4cy9TEdzqNLmorcnIlG4QAl9kzQWEOgeldFXLbMclxjQUrcN+i6Hj/D+XJMviIXESOC61kbhR6t7wZjo6RDBYe+vHs1WGMWlIeEHRMc6Mayo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708786; c=relaxed/simple;
	bh=yaBx1IY8ff3A1bbs9mYGo7g51gLt9j4XhksXZVYnSZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vCnJ3NmEq+kynDbgcGqxAUqbvlMF4Ucoa9C4K+mYMuP+4RbtJ4AG1Aev3r9rzU1Jm2Dq+ot0RcAjq9Vhlw59JBNTIR7hRJZXDGBwdHIs48NwyjtsnyMk5pAgCjM/3V4GiAYNQ5Fdc4xGkiYTw8pbn37KqozUhMKp04J+05h8py0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AkFXgbG5; arc=fail smtp.client-ip=52.103.13.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McvNrYo7OPA6s9mK/UMOgg16VlROp/2zuj9C/HRzkfdPJ4cVHhUIyp1Cou8K/e5agAJ3E7DCyuBvUdQzId92QZcpj+UndlEtvtGzY1xf+ngsn+yHJ5C2CgocsoY4TfGOhDH51szmeaWRJKxAbhWm3CiYx6Ka9vbxC9V/aeaUxGETztW8LvINNOcHwmpuf15lR5Erk3EqnM0Ppz0rRIiXZ1BsSfqzSwXLiHkpWyy4qfPoNrjdtn2TEAQHJ5YYiJVT3qWASOrKokwxBWhmTM0GSKOiFAP9mywHubAawNyjn5eqAJjMWXIPfkYumx6+spnT0Bm7evdIPKdodkJHVylcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaBx1IY8ff3A1bbs9mYGo7g51gLt9j4XhksXZVYnSZQ=;
 b=ADYqg3wt8INdguO4k5JG4CbB2MCAkn92ZMp1k3Fpvqi62yofw1M3p30bo8WD8ORAitAicu2cap2PeOE4SRlnFxy6aBL6SAjU/x//s42Bg3PrKUdi6QjT09WHalaMJ2q1jDTWOdZKJByLqL6F8JVVUV7qo/+1a6C2+y436cxNd/KnnpbwpvBo19+X6IB8wCq9YZ/YIJc3i9UfTbLbyAaN89/LTivR6HgdrLd5nQjSlu936RqOVHAllHQoOrHrrHbeJGvkums/EPv3islC6AWgvAQLJCsQNvUFySuYHdzTBeBskzNGYdhXMmfftRKP74aIeEMnzKvP/ef80TMtZFES8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaBx1IY8ff3A1bbs9mYGo7g51gLt9j4XhksXZVYnSZQ=;
 b=AkFXgbG5yGFSbh1BRZTZtjEQkWYyHWW4iCN6mjtcXLs8iSivLmKq+XewkoE9xNuYek9oGP224FHDKEmDfI2avDHZvQopZDGTLj9yQVJnhxmAn7AE/eUZif66Ck65VBa8ghjLzQ6VBF/RbsNvvdgb6GMUXr1+9kzqAgYES+MUJon5uJw57UG0PCpEvIkfzWTrhg2aegcTzANmqxNzxUG0lJ6AJzMReYshMkZ94qNkEiQZCjVguJHB93ShhqfzdeVp+wKK/LHqsU3cb1m6E+vDB2ixwub130I/fFdZOvZw1HL1fzTLdtU+2g0Bv/1X26+ptK9azvXtrxeJrank56XDyQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB11031.namprd02.prod.outlook.com (2603:10b6:208:5ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 17:46:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 17:46:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] hyperv: Sync guest VMM capabilities structure with
 Microsoft Hypervisor ABI
Thread-Topic: [PATCH 1/2] hyperv: Sync guest VMM capabilities structure with
 Microsoft Hypervisor ABI
Thread-Index: AQHciyc+yyMuHHUDQU65TYp2uyl9BbVpZ60Q
Date: Thu, 29 Jan 2026 17:46:21 +0000
Message-ID:
 <SN6PR02MB4157CE884C53D7C6C61D940CD49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495416.166619.16629695002971245203.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <176903495416.166619.16629695002971245203.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB11031:EE_
x-ms-office365-filtering-correlation-id: acf36a11-0bda-4488-1d1c-08de5f5e5095
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc6c3c4/rztiZGf6bH6e/ZC+3WhHxxQwcShUF2Kod4u8zFzkYQuVzbuqOWvSKFf6YrzL10+ZeibRhElRSXrxYgsPowcdExmT47LortGQK2RdQJNFaFpQVsla3kkQaNmyfRzUMwJVT0Dw2xcIb1I7eQSFUOJS1XLUIwgffCcoy1HvT2AqvwOmGxjE+5laJC81vQmRLTQPjBYpr5I2xraVcc6QVuxt5cGb9PIva3WJzcR7TlXyqYH83dc2ZbKLfFP4nTMozDvJw54qyXkYsFMG8Xos44rYQEnJ3+pk2tHq0PcXxykaz7E/ic37awxUKlwyRxQ+TYVHqSQSlwtJO3BsH3Qnz8G7EpEA7eBkGcJax0sk9/C+mKIJ+tJNdyIANS2O3LCh7IUuXnSD2mhZfI12Ryt+NXuZfN01kidCx50Vj1WT2br7hAJALdNRHslA6TrTXZl+CzwRgFGhdtjM5wVcVzULTrDRyvabNNndqTwRBkw8A5JZ2N8nStt3JnImWPl61ig3Hg5bUsPDOYBYo33e1GBZ5qZ9jmPvB8krdT96eIKT7Fz0lmuLY4m5XzSH8DAKw6ozEWs8WVwmeQDvj3tr/zCfAtTWEFbKg3N6pNh3o7qh9ez9O8bL4aiPws8lFNHI+9XKLQA8t0zWXG5Hzla1egRdF9p6jx9J4bqyVgSkwcDIo75xsJlc4KQ7oiqQ/LUjCPMU/JoIeDH6FpbFewmNF25CPNDV6ILcciMu9aZJ+SofbOZki5K1Y+2
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799015|8062599012|15080799012|13091999003|31061999003|51005399006|12121999013|19110799012|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekhMREUrM2hWYXlCbWZoKys1cGw5WHFLblFXaE5OM0ZhV0oyNzhDZUFGcFpF?=
 =?utf-8?B?cS9kTlFnaXdpaSswanNrMG8vMWhzMGRnbWRneWVPaTBhT2hjZzNrSFBDOHU3?=
 =?utf-8?B?UzlxZDk3R21ucUZjTDNPVkgzcENBdE5ndkw3elo1eHVOZWN5cjBnSUNvV1pv?=
 =?utf-8?B?MVY5Si9KUVFRVFFNNXl0a3ZQV2ZiQmxIbEl6Z1U1ZVJKSTVMNjErMXpueEFI?=
 =?utf-8?B?c0JReVJrc1lHL1lLc1QrUmcxY3ZMcHMralhQY3VpcHR4UVdUbUpCaVhKelNE?=
 =?utf-8?B?SUw4b0pwUWhQMUVIREFHNXY3MTVXZm9vdkt6QUJqMVhDemRXM0RsdGNEL1lI?=
 =?utf-8?B?WDhYN2E5UjhQRm15YnA5MG5DbmdIYVE1K3lncmNicm94RE9uajZrOUpEVGt5?=
 =?utf-8?B?a09kY1Nsd2JFZCtXaTNUaEsweDFRN05oNE5MV3FaRGhCV1BPenppV1JMSHVj?=
 =?utf-8?B?T0FzcWE3clh6ODFVcGI3cThZaS9PdFBGVEZad1FDSE85dnA1ZDRNdDRUZllw?=
 =?utf-8?B?ejdmcmpjWEcxeWsvK013TFNHbmErWG9WaUQvZjUrQWRkQlFpMTFNL2F5K0xj?=
 =?utf-8?B?Y0Q3QW1Gc29KK1dsYmU4aFhsK2VHeDRMU3ZpQ0ErWUNzTGF4c3k2ZjI5V1dl?=
 =?utf-8?B?SWdHQUkrb29kRjg2VFU3WEwwdlB3eWVZeWdLWFFQRGxZM1ozd2txWGQ5eEp2?=
 =?utf-8?B?ZWE0SmtWa3JMeDFYNThGaW5IREZONG9jUW9wRTlrY1dYekd4blJjMlRpdVlm?=
 =?utf-8?B?d0ZLY2RHU0lzclJJbzRqdTc0emZXZmhtbCtLL1FDYzNLK05uOG8zdjlPU1NW?=
 =?utf-8?B?ZmRrKzNwL0h0d2d4UlloTVFxcG9OcERxa3crcGlPbG1vQlBQVEN2TWIzU3k4?=
 =?utf-8?B?blV1c2ZzUEgrVjAvdmJXR3UxZjlQSncvRTUyOGtuY3FnWXliaXRsZU1RUzJB?=
 =?utf-8?B?bk5Oc2FQakY5bVYwOWFEL0k4SEpPOTJqOUVLZWw1dUxrSkMxNGNwOE9CYzhi?=
 =?utf-8?B?WDVwRnRUVmNyWEU4dUpqQnZpUjk1eitKWC9aZ3hNMmN4NElNNTRJN0VRZ1JN?=
 =?utf-8?B?M2pLUjVBTmlPaFlocE1WZ2tTTFRvMlhlU2l6MXNyQU5UMmZ0aVZoZXNLam1q?=
 =?utf-8?B?dXpsVGZtNFRVWFVncWRKNGNBMkZrTS9mR0ZvTFhKT2hnTHNxb3g5TE9sZ0xv?=
 =?utf-8?B?NlVpNnpHcEdpbHNsYTBsbjZpTjBKT25TZFFNb0RVdnBIb3BEVEc1SHYzMHJI?=
 =?utf-8?B?ZlAxeWxrNGtaOEUrUWtkL015RUVubmFZaXg4N1NCMkc2WmtsMGpqUUNSc09j?=
 =?utf-8?B?eEtkWmI0YTdzT1BOdXIyQmRvQ2diaG40UWY0d0MxQTEwMUNQTE1mTm9Bck9i?=
 =?utf-8?B?cE5yNUxzM1VodGlvNWRMWmkvK3dGVnBMSk5taVlhMlNuc0g3ckk0bk1XY3NQ?=
 =?utf-8?B?UGV0UmFYOVRvVDdiTFZta1hUWGhKclA0QVJ0b2ViVG1pQlo3dXBLbHlnUnJu?=
 =?utf-8?B?QUdYdHprb2NRYUlodnE4UG9ManFrZVV2R1JidE8rSWdhclRUODgxTzEyTEZR?=
 =?utf-8?B?SHIwOWpPTzhPNUZjdUpuekViY0hMbE5QUjhieVljOUZadThHSEZxRFlZRncz?=
 =?utf-8?Q?mz6xI78s6MIslElvsL8Jmv9dunCsN03XoqV+Oo3KJG2w=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXpZYlYxM3ZvcE1qRnFLMHRuSSsySnVNQ2JUOXZ6eExjK2ZaN2RsVUtQVUgz?=
 =?utf-8?B?YzVFWCt1R3hWN2ltamdUem5tUVZNbjdPK3lTNFFlTmc3YUMrMnNWdDJheVlZ?=
 =?utf-8?B?a05EcHBObVJ6S1pFK21rRGlzY2tOS1l2WWtZTmIrTDA2eHQ1NUFNNm5QRzZh?=
 =?utf-8?B?cHVLTjhRaGlwT2FvWDhmamh0cFU4cUhSTkwyMWNNNDNUVFgrM0pyQURWdEdX?=
 =?utf-8?B?MC94M0ttZzdVRG5WSkRPckp1N2xXMThpQ0ZkeDZRdnJVVHErNnRoWjdCMVdW?=
 =?utf-8?B?VDkzYzIxd2FPM1Z5WmJpUEI5OW43S09hSEZzTEZTa1JKUHJYdXNFV3ZDTjVj?=
 =?utf-8?B?ZVExNkV5cGR5RXphU2NGbDFsd3V4OU9LazAvSlFrNmVNSU1rYmdZL1I0K2JO?=
 =?utf-8?B?aWlRak9BenNBVWtvOU04Y0RtOXhONUVEZTlCMm5YLzFkRHpRUjhXMnUrdXAy?=
 =?utf-8?B?Uml0cjc2RWxkZkE4aHRwVERFYzljT2ZEaVFYZ0NaRUQ3MjFGWkY0SWVMY21o?=
 =?utf-8?B?cHpHc2ZYM3Zadlp1dVdhK0dNUTJCN2tXcGdmOENBR0s2cjlxVmxNNUQzTklp?=
 =?utf-8?B?RzJyRUtFcWl6R1p2NWp1d2I0d0djd2JHaUpkS2lzV09UVU12VkJzRFN0ZUZC?=
 =?utf-8?B?UDUyczdhZEdiSmw5SElTTWtEZ1VQVjFvTU5QY01qTVUyaENkMnczQ2dDQTVa?=
 =?utf-8?B?Vm9Bczh1SktIVUZFaDJ5VThrWVl4NUZ4R2JMRnRObzBOeFVwdDVOVTdXL0pJ?=
 =?utf-8?B?VzdZdlpvKzhtVHdhT2EydjR1UzNsdXRXdzJmU2hlTG53SWZLcVZZd0pibmw0?=
 =?utf-8?B?ano5eCtyYW5sTi9uRWVja3Z6ZEdadHIveW5sZ3pIS0FRUUc2RXoyaWhqN3pt?=
 =?utf-8?B?RGJDaE9XVHZWakZVY1hlcUZrSmdzQno3VDd3cUFvdDhBZHVSZElPUEhvcWFV?=
 =?utf-8?B?eDZoRDVaQlNHczNsRXVhdDNweEY1WVZnOEh0S0dQc0tYaENhTEFuc3VOY0w2?=
 =?utf-8?B?ZUo1blRjQS9oa3NZWStERFpNYnptRlBMZ2MwZTI5Lzc5M0NodklRb0xyS0tt?=
 =?utf-8?B?WGo2aUNCQ1NVRjE2emVhci8ySDMvMkFzQkRLSDlEZUpuYkEwVExDMzJDYi9w?=
 =?utf-8?B?OXVyZjdhdFNjY3UvdURaNUlwUW1uS2tWQVIrejh3bVJCWFg0SG1HNTE1RWsy?=
 =?utf-8?B?Z2NhSU13UGxmSTIvaThodE9sTDlKTGhKaHIrM0d0QWltVDgxeXFWY2d6WVJa?=
 =?utf-8?B?a2M4clBvY29rZVFqb3dNNHlXT0c4VVA5N01YcDJ5WWlYUG92dTdCazkvUEdT?=
 =?utf-8?B?aEhRK0dqalpwYVB1b1h6cGlBUHVsVUwxd214SElxL2NzcDFiSnEweFQxSkg0?=
 =?utf-8?B?NWZMeTdMTGdpZ280eHczdUlzOGtoV2ZuL1Urdzc0RWhqK3d2a2lPSWZpeDRw?=
 =?utf-8?B?cDRCMDZ2R0gzK0xHVkMxNm9IendaMWVwVVRIeC9DNUZGZTc2bDJhUDRyWVJY?=
 =?utf-8?B?TStaV1lxMHlWNDhsZXB4dG5STnpxa2F0TGlHSDc5RFh5K1h4YVM5STBWbVBx?=
 =?utf-8?B?OTRISC9nV0ZjdFhOQjRhZEtxU3pxOXc3M2l3MVd6RTluTGV6aVJFTzVqZitW?=
 =?utf-8?B?UVJodjlHZmRaTFZoSWoyRkNuSldUb05sWjMwN2prU1NBQWZXa3pFTkN5SDU1?=
 =?utf-8?B?V2hYSGdWcHBla3lSNStTU3VZNm9tSlUzaC9vd0NjcnZXRmE4bGZ5bTJNbTh3?=
 =?utf-8?B?RElHekowYWI3M2NmRlR3dU0zL3RvSWIzQThnOUVSNW93UlQ5S0JpNFJpY0Rn?=
 =?utf-8?Q?muNXljamkifs9wOipIQI8LNpak4naJ2e8yLi0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: acf36a11-0bda-4488-1d1c-08de5f5e5095
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 17:46:21.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB11031
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8587-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F35DBB32F9
X-Rspamd-Action: no action

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIxLCAyMDI2IDI6MzYgUE0NCj4gDQo+IEZy
b206IEFuZHJlZWEgUGludGlsaWUgPGFucGludGlsQG1pY3Jvc29mdC5jb20+DQo+IA0KPiBVcGRh
dGUgdGhlIHBhcnRpdGlvbiBWTU0gY2FwYWJpbGl0eSBzdHJ1Y3R1cmUgdG8gbWF0Y2ggdGhlIGh5
cGVydmlzb3INCj4gcmVwcmVzZW50YXRpb24gdG8gYnJpbmcgaXQgdG8gdGhlIHVwIHRvIGRhdGUg
c3RhdGUuIEEgcHJlY3Vyc29yIHBhdGNoIGZvcg0KPiBSb290LW9uLUNvcmUgc2NoZWR1bGVyIGZl
YXR1cmUgc3VwcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlZWEgUGludGlsaWUgPGFu
cGludGlsQG1pY3Jvc29mdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVy
c2tpaSA8c2tpbnNidXJza2lpQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiAgaW5jbHVk
ZS9oeXBlcnYvaHZoZGtfbWluaS5oIHwgICAgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h5
cGVydi9odmhka19taW5pLmggYi9pbmNsdWRlL2h5cGVydi9odmhka19taW5pLmgNCj4gaW5kZXgg
NDFhMjliZjhlYzE0Li5hYTAzNjE2Zjk2NWIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHlwZXJ2
L2h2aGRrX21pbmkuaA0KPiArKysgYi9pbmNsdWRlL2h5cGVydi9odmhka19taW5pLmgNCj4gQEAg
LTEwMiw3ICsxMDIsNyBAQCBlbnVtIGh2X3BhcnRpdGlvbl9wcm9wZXJ0eV9jb2RlIHsNCj4gIH07
DQo+IA0KPiAgI2RlZmluZSBIVl9QQVJUSVRJT05fVk1NX0NBUEFCSUxJVElFU19CQU5LX0NPVU5U
CQkxDQo+IC0jZGVmaW5lIEhWX1BBUlRJVElPTl9WTU1fQ0FQQUJJTElUSUVTX1JFU0VSVkVEX0JJ
VEZJRUxEX0NPVU5UCTU5DQo+ICsjZGVmaW5lIEhWX1BBUlRJVElPTl9WTU1fQ0FQQUJJTElUSUVT
X1JFU0VSVkVEX0JJVEZJRUxEX0NPVU5UCTU4DQo+IA0KPiAgc3RydWN0IGh2X3BhcnRpdGlvbl9w
cm9wZXJ0eV92bW1fY2FwYWJpbGl0aWVzIHsNCj4gIAl1MTYgYmFua19jb3VudDsNCj4gQEAgLTEx
OSw2ICsxMTksNyBAQCBzdHJ1Y3QgaHZfcGFydGl0aW9uX3Byb3BlcnR5X3ZtbV9jYXBhYmlsaXRp
ZXMgew0KPiAgCQkJdTY0IHJlc2VydmVkYml0MzogMTsNCj4gICNlbmRpZg0KPiAgCQkJdTY0IGFz
c2lnbmFibGVfc3ludGhldGljX3Byb2NfZmVhdHVyZXM6IDE7DQo+ICsJCQl1NjQgdGFnX2h2X21l
c3NhZ2VfZnJvbV9jaGlsZDogMTsNCj4gIAkJCXU2NCByZXNlcnZlZDA6IEhWX1BBUlRJVElPTl9W
TU1fQ0FQQUJJTElUSUVTX1JFU0VSVkVEX0JJVEZJRUxEX0NPVU5UOw0KPiAgCQl9IF9fcGFja2Vk
Ow0KPiAgCX07DQoNClRoZSB0YWdfaHZfbWVzc2FnZV9mcm9tX2NoaWxkIGZpZWxkIGlzIG5vdCB1
c2VkIGluIHRoZSAybmQgcGF0Y2ggb2YgdGhpcw0KcGF0Y2ggc2V0LCBzbyBpdCBpcyBhZGRlZCBi
dXQgbmV2ZXIgdXNlZC4gSXMgaXQgYWRkZWQganVzdCB0byBiZSBhIHBsYWNlaG9sZGVyDQpzbyB0
aGF0IGZpZWxkIHZtbV9lbmFibGVfaW50ZWdyYXRlZF9zY2hlZHVsZXIgY2FuIGJlIGFkZGVkIGlu
IHRoZSAybmQgcGF0Y2g/DQpJZiB0aGF0J3MgdGhlIGNhc2UsIEknZCBzdWdnZXN0IGRyb3BwaW5n
IHRoaXMgcGF0Y2gsIGFuZCBoYXZlIHRoZSAybmQgcGF0Y2gNCmFkZCBhICJyZXNlcnZlZGJpdDUi
IGZpZWxkIGFsb25nIHdpdGggdm1tX2VuYWJsZV9pbnRlZ3JhdGVkX3NjaGVkdWxlci4NCg0KSWYg
bGF0ZXIgdGhlcmUgaXMgYSB1c2UgZm9yIHRhZ19odl9tZXNzYWdlX2Zyb21fY2hpbGQsIHRoZSAi
cmVzZXJ2ZWRiaXQ1Ig0KZmllbGQgY2FuIGJlIHJlbmFtZWQgYXQgdGhhdCB0aW1lLg0KDQpNaWNo
YWVsDQo=

