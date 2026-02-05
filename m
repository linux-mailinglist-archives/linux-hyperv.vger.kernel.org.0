Return-Path: <linux-hyperv+bounces-8728-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKjBGXylhGmI3wMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8728-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 15:13:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF326F3D51
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08E5C3019BB8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A23EF0B1;
	Thu,  5 Feb 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uuKjmQAb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF93B19F;
	Thu,  5 Feb 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300598; cv=fail; b=cKwDkw6Dqx560hE8EgAkf4O2cDfBGOtltPxT4yxdrpYFHSyBd7d6Lrw7u4HinjXEsMvgFzz/E+w2YPB8V0EU3cEDZgLfV3asVVhlWwX9eGSE2A+Cv6iVNZXxJxTEsSr6gyE2KKfkHnxfn/mug+qLAvA72/vR9Y7CtEgncRmGWFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300598; c=relaxed/simple;
	bh=EVz6SVJu7P472tO6D8juYE2E9cKO6rWkK+/Bm3BYzwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWysSkOe+TB2G3l2rRIBdKGNUVHJJzkR4+q+96zfLwdZvqEN4rxJj1aAymN2YswD7wV3GXMw2skxL9YUbfbNVnjwOl/q+dCPkayxUrCJ1yZIBSWCSNY7+YcV6nXZrFCOe8vM14Ldps/yLUs1Jx/BPjpK7f0iGmCoijXZRy3JkBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uuKjmQAb; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZXGeTOEzBLbTZ/GPcjYff1FmBeNsRuFueEbsBMZ0xl/2dIitdz46lmos4aY3a3S3w9J563Q0pkYjqyWqYNvX2wAX3ibIkHmZbv4eqceDNFu2rzmkKwyVjQU3ciUJmoyP3eggmwisDSnSqO/wa4gq1v+v75JgPXHceSgIzl26Yxp/ubRf1ZL1gdI3bf5nzOv5JCzMfLvZqV0MSsOb7t1abD3Ds6DOdnfi9TqEiEsEizxre2Df+1W7JasuZy0hdUshfqiW4EDVlQf6ezG/2ZDUTFKUup2v5HP8bJ1H8ryISccNLNh/SHeNYcihuAfSItBa0xS0rq6iXoapcUgKGYRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVz6SVJu7P472tO6D8juYE2E9cKO6rWkK+/Bm3BYzwo=;
 b=XTsi8zZH9AOy3WbFgujzobcsFEV0UXL1rcXvi5nX6W3ZWdzAIgLsiX8qvaxI7KtPw9/jJ4/KwxvoBro1UUmGhHhrhQ4bomu7CSQVdNS0X3EEp4NnMxcNIzDxw8OLP3SU8a+uq09HCNqxojqzbMcbLr1wNVMA6Hm5+/W4c81u1Av8zuQXVu6wkZcJrM1Ee3qhkqOzGWWSomy27Hu4vRTz507PI5DbO2Lt0wqvgevaMATsRMPQsxINExCZemtnntd14j1z7f/Iul7FMYnGKu6zGAVc9ct3cPjk14fO0/gTJHik6rE4Vu1J4/Sbj+xWEvX4wnOQmsZvQoWk59hPXgse2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVz6SVJu7P472tO6D8juYE2E9cKO6rWkK+/Bm3BYzwo=;
 b=uuKjmQAbCtMTqTaz0F4mDXtOxfiN0uEA8TwU5Ox3yZGFoY4LBLv0J+XeyA0M/QucA4WJHDhzWYWtKRcwfTf5S62yNngxhg8++Jw6SptPUGpccE7vQh91GPs/VD7W/Xu+eSlmSGj6RtImRStpvxPxwAvuNfb4H7tk/9MVcih5I9mJ/tRefFjoPD/iTALHT/DaUFD8hOmxjH5p/PlIdkPSgJM/NL98fhcw8ULHLMq1jZSUpeTLyTtWaaymIrYUnkMUoT54AqbkzwLBs2sOpY0iu5/0Qcf4Ge1IstWhHp2u2btmr8IKHoxaz+UosroZxh3n7jXTXgT8UeLCqutHOe+eOA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PAXPR10MB7928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:09:53 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 14:09:52 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "kys@microsoft.com" <kys@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
Subject: Re: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
Thread-Topic: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
Thread-Index: AQHckSvbIOIGCgQgJ0u8eSLZXd/HDrV0L9iA
Date: Thu, 5 Feb 2026 14:09:51 +0000
Message-ID: <7c9d143d9e70a9ff9b91fb5a55d8ba57bf1cc4f6.camel@siemens.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
In-Reply-To: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.2 (3.58.2-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|PAXPR10MB7928:EE_
x-ms-office365-filtering-correlation-id: 24bb7094-a80c-4934-3977-08de64c03b10
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTVuN0NzVUlodEtJL3Z1SXpzWFZoRFNseUJIczNpdEpDREtWMEQwNm9aRldY?=
 =?utf-8?B?Y3FTQ0w0TC9mTWkvS1lFRU91bkpndGx6QlpQZlNTSDYwZ2Y2SmtONFpRTEkw?=
 =?utf-8?B?SUJIeXhpaU5qd2s5b2lvKzVGMmNTam1xN2JiOGRsRjR2bnF4TlJ5b1VFejIw?=
 =?utf-8?B?dXMzMFRmLy84ZW5OREtSTkpibm5XUzJhMkQza1ZIOXhBZEVsU3cvdUJWOEZQ?=
 =?utf-8?B?Q1lPYkNMVUo5UW44QXFvRngrb0RaeHFhVFJDVUI3Tll4RnZNYnBtdUZGNFR2?=
 =?utf-8?B?OWdyOEpVYmpldTBNYThpMDA0cFB4eTNiVVYySVZoWjlObmVDajRCbFFxTnNs?=
 =?utf-8?B?bUVzYm1Qd2srSDNsTnpqcXVRU3NwTVVwVE9mZXFRaktzdGh5TVdBS1NFa2Fx?=
 =?utf-8?B?cmpJVVVLZ1pkalhSOXplUVhjMC9zUWxtTnZOTEljaFZYRlNRRThodytFT2V5?=
 =?utf-8?B?Rjh5NEkxcTJUU1Y4TVZuV2V6UFJ0RW1wcFNueDBWQ3Qya05wenQyRTVkRWZP?=
 =?utf-8?B?YWxyYWliYXBva2pJRDl6VW9OeThUT0FXKzUxNlBUeXF0bWxZU3J3djdrWFhn?=
 =?utf-8?B?ZFhQcm16N05kQlhSVVBCS3hSWXFVUUtmVHNuTVJWWUxybVFWN1l3OFFjUmNE?=
 =?utf-8?B?THZPWHZnSjJlNjZoc2FEREhkQnRjSlBWYVFGQnY2d2xQN3BIMXAxTGFXYW15?=
 =?utf-8?B?VjVzK3NOY2dKbTV3MXdpL0NSMWgzMkcyak5tZ0RPbkJFdFdMRHBiTVVaYVhR?=
 =?utf-8?B?cm1MRm5kaDdwQXJtQ1dxZC9CVExCeU9sS3ZCbk11N1VqbkhjODlNaHJJejJM?=
 =?utf-8?B?Vi9tcmwxZklVUFNxUkNodEt0VzVTMFdpSlRuUzVIWklyekk0Ulkxak80TkdW?=
 =?utf-8?B?bnFPRVFGa2N1U1lreGVEeGRIZ3ZGaFNmTkVUbHBOUlk0Z0tyc2NIT0hCdC9C?=
 =?utf-8?B?aUNGTUxRdmQ0R1RZM3pXWWVxZWJBRDFFV2dYSWU5dEcyZ1ZjNW5ET3BONzZr?=
 =?utf-8?B?bDZ4MU5zc3ZXb2FVY3VBSU1QRXRocVFxS1FxN2xSWXZQcWxSbEF0SnhNaEpq?=
 =?utf-8?B?YXZzTFByQUdPdTBVazBpOUFQSGNHc1dJT1hRMTZnb0NCTG56MWJhM051K28r?=
 =?utf-8?B?Q1pMMkFrVk5XbUxIV2ZDQTRmYi82TGtXUi9qczRuUEtwZHNZZGJiUXhPRkxu?=
 =?utf-8?B?OTJvYkV3QkdoRmRIRU1mYUc2M2tVdFQxaS9iUEU5SHRTYjBvbjZlUlhQamM1?=
 =?utf-8?B?a01mMDNYNHRXN1pjb1MxRVBPL1A1YmU2Yyt1YndEV05KMXI2RjB2ci9abGFU?=
 =?utf-8?B?RHBEaGRpRUFiUXJHWVhSZytaa1JidW9jU1VWeUp2ZlBoSmkwYmtKR2xTVjVh?=
 =?utf-8?B?QnlDMi84SUl6aEtpUmRkS0ZiZ0oyOUxtMFkrSCsxd0tVMUMzZW00Zk5JTlZz?=
 =?utf-8?B?eFlLRnhFdHI3YVBXQzBXWHNZcVdJT0xHWjY5bXBOQXllY3VZUFA0Wk5LcS9z?=
 =?utf-8?B?a2FONEFUZ2Q4ditFUWZMemlWcVZiM0d5M3BJQUtmM0syN2c2QlJxZTBBUGtQ?=
 =?utf-8?B?T25zK1BRZ2VQdlhZMnNnemtqM1MxaktWbnM1c1FrU2RuVWlNOVpCM0ZwQ3hL?=
 =?utf-8?B?bDZydGd1MndzdGZ4ZU5kak93aC9YU1U2Z1VXSzNtTmpwREFGbjEvVDF1bDF3?=
 =?utf-8?B?QTRhNm5ra3J2bWY4cmtKeHdjV01UQjFVSjdxaFlZMDlSNHpDSUlFL0tkZHNQ?=
 =?utf-8?B?Qm5DZWFUMW01OTFudEtmRCtkQzFtUVdLdDRZQjhpR0xsZ2RTMVVpc242YWdr?=
 =?utf-8?B?L3k4S0FBSWpRTEZKNmxjQzVIY3VpOEhvek1vTmdieWJZdFJpcGpiMjJObWV5?=
 =?utf-8?B?MmVNWlBmNVp4SVU3bTBxMlVMbit3RVQwZzRkNnN5dnI1cVE4U1k0U3k1T1hG?=
 =?utf-8?B?TmxSQytucEJtaWdWWUFoN05rL2ZjNFBlUzIvZWF5ME5zeSsvUWUvZGhUTjlO?=
 =?utf-8?B?aGxKanR4NDRkUklLc2RsejdpQXRhYndGRHR0Lzgxcm9GSFc0MjZHTUw5K0d5?=
 =?utf-8?B?c0toOW8zMWVkWXRLV0hmMnNWZHc2a3ZPYURmOUQ4Q25mNysvYWxyMGM4d1Zm?=
 =?utf-8?B?OW5OeVBra2NjWXgyNHpVNFoyWXpQUWxtSzRvbHVsS2UvQkNVZWd2SnlMU2Ft?=
 =?utf-8?Q?yZgSGMugz/4p6fez6759vOWaIGEI58EgX8872mTO8FuY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUJLOUNZOENFZ3VzZzBKYll4TWFqbWN1NjQ3bkhLSzV6TXZKSm40TWpJY3JL?=
 =?utf-8?B?aTJ4b2pQUFYzaTg2U1NHMldjd3VPSlBvbXB3TncvWkJHZ1gya09XZk5QYzlt?=
 =?utf-8?B?cHY1dG1LSnZGQ2J1M0haUE9EUE5vTnFjc24yajF3b0MwZW1OZlZkcjZUd2Nu?=
 =?utf-8?B?TnVGS0RlVzlqNDd4VXZjNk54c3pIL01tVTRxb2FzQTI5ci92ekhyMks4d0lu?=
 =?utf-8?B?cEhIR1BRc2k0dHBhbEo2Qk9WOVdOYXE3Vm1lUUFKdmVka1d6dWFhbEtOdGxY?=
 =?utf-8?B?V2VkdEpEMUJ4SnVKVUxBd0VmQy9OaEVXVW1MeTN1NWNEaHlLMWRPdkxsazlD?=
 =?utf-8?B?aWxUZUVFeVBGL0xqS2FFZE45QWZHMkpoUm5ZZ3Z2TmViNUNMRnl2SkJ1QkJY?=
 =?utf-8?B?eC8yOTdNZkpkUFpCRXRRQVF2YmRjbWtzbUgwWjNpOHorZUcxRlNqWVQ1N1J4?=
 =?utf-8?B?WnNObUoyMzdYR0pSNnB3VjRoL2s5VWF2NEJMUE5ESUxIaW1RaEpXMFExdXpC?=
 =?utf-8?B?cjdaakxtUFY5STdFaHVTN0JHeDMxeUQ4am5BUGZzcU5WQTlWbStoOHlrdHZT?=
 =?utf-8?B?bzhZSXpnclBOYlppVFA2b2NuQnB6cXV1MHFBNXJ6WTExNkVmTk1wdmJJejE0?=
 =?utf-8?B?b0gvVXQ5dHBIdTZzNWQ2S0JGY05ybll0dUNUUXdxRlZrS2UyQnVPQXZJSjlt?=
 =?utf-8?B?elpFMmd2ekc0eVVaR05VcDJhOUNtTEc5dnV6aFNrSlpvV3R0YUpmdjRNb00x?=
 =?utf-8?B?a05HSklsblNVbHlVb0lDVmJjUmFaQU95SzIwVkJBVDhXMExSSkFtdXFiM0U1?=
 =?utf-8?B?WnBNcXk4Uy9ZNFBlR09tOUQzR1h0cFpKeXc3dzJFY1VhNUt6MGJLR0JqaW5j?=
 =?utf-8?B?N2pQVkZpRjN3NmljRXJXMHhCYkJlWU9uZWk3L2ZPRzJrMFIvcW95cm5wZW92?=
 =?utf-8?B?WWhQajZDbjZvRmRvbjNpUzQvYmcwQWRKRURYaXNpRnhpekhpVEEvSVJ5Qnl6?=
 =?utf-8?B?a2VMOUwwaGR2eWtDaTlmT3RTeVBsREpPZFRQRVBWYW5DUU1XK3gxRnV6Y1Zh?=
 =?utf-8?B?TlVTcGY2V0cxMGlFcDl3Z1NJVnNZUGROVzJiQUwrTnpPWmQxVmtoeklrVndY?=
 =?utf-8?B?Q3hvMjlPMklJV25JUGZPL2JwcWJwV21HZE80VE90ay9ZakRySHVLdnh1ZWNi?=
 =?utf-8?B?ZUloZEF5N3FQaHlmWm12eStmYm5vZGJUVWYzUTBaZGFlL0U3OVJvdnNleWhl?=
 =?utf-8?B?aU40YmNRWnBqRjBBZXBVMHVkT2NYM25KWXRISVhneHAvTThzUHBoVThrSUVP?=
 =?utf-8?B?WXZDTjNMaW9zUG5Xd0RTYVZIcnNBNGx1VjhtRWk1bnhrTFlCRllROXo5a0pV?=
 =?utf-8?B?RjVTazNBc1IvazBsaW41VHk4dDgxbE12V09YRTFaVnFQVWRDdHFHOFNPT0JF?=
 =?utf-8?B?VEVXQ3pDcXF5cFlKbVorQWh1SlliUXpHRHhKU0Z0YlNNVVhIZjAvVzhDUTlL?=
 =?utf-8?B?S3FRTnJqV3gvWlAvY01vNTBSa0tRS1BOKzdVT1lRM0FwZVpHR0tsR2M3eHZj?=
 =?utf-8?B?cjlld0RuQldtckk3ZExSZDRTclJPVlJBMmlvWTNJazRpVTNFcWNtYlAraVAr?=
 =?utf-8?B?UWphU29jdjJ6RGtjaEpYdWp5d0xMbjEzRVgzcHRWM3d6NFpvcGxDcHk1bzdU?=
 =?utf-8?B?V09EekpwdGVKK0RVWTg2OURPY0R4azdkUkc0Y1B1UVAvM21hTC8yRVBYeEhB?=
 =?utf-8?B?b25MNjRDRG1HM2NsQzhrcGJGZXBZTkZBMXpnaElsQld5akFFdVMyV2NEeEcx?=
 =?utf-8?B?UE5CWllTSDFaSVZQdFQyU0RMaWh2OCt6SW96S0Qvc2NBNDRKKzRlamhnc0k0?=
 =?utf-8?B?Y1A0SE5tTjRUVjI1b3ZHcFhCdm5pbDFxV0w2NGFkV08ySzUrcytUL2FwZ2Jl?=
 =?utf-8?B?U1V1VG5sd3VZVkVQUzBUMkJwdVQxZFZYdFVlMlEyOFh6ZHpyd0I3Rlcvb1di?=
 =?utf-8?B?d056K2FZb1AzaVlUUTBic1pkVVVrMm9mczhvajBjdDRucjlFNUtHOEViNmUy?=
 =?utf-8?B?ZHFydG5YV1IzcCtlOWlYMTlFamEvazlrN2RJMGpXVk5FdXhLM1dkSDVvMHFD?=
 =?utf-8?B?Ni8zck5ZT29Rem9LWjJ3dHRYY2lyQlJxTkRLdXVNNm91TG1JUmZ4Wm93eDZr?=
 =?utf-8?B?Sit4Y2tuY0Zzd3NZRHRaN2NId2orQTU0c2I4VEJFWEphRVVNRTRSTnpMTnE1?=
 =?utf-8?B?dExtZHJhVVZINExqWFVhd1VDeVJXb1ZpbVhjQzQzamFYc1dlWDdMT0JyUGVF?=
 =?utf-8?B?c2cxdTJESk5IY1E0dXBkKzBsZk1zUUQ4ZnpVdG9iR0lmOWVmSVdtSE1qdmJY?=
 =?utf-8?Q?5x34XhmyZoYJaD4tlIdW4+MyAU8BOm8tAQhpcFsC6aCyn?=
x-ms-exchange-antispam-messagedata-1: 0MMNgTcbc2e6OOMGJgbHbyokuoUgs+ClcTo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <020ABB569AA29E449480CA0FC24949F2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bb7094-a80c-4934-3977-08de64c03b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 14:09:52.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzSD8tx1X8LRO1i61eXtFZN7rHxxeibRX9TcZ8Hz/ghB0s7KXuy58Ys1oqdQx0Z6yD0sgc9xlLH9QuNQS8WaGYhjxua+NXz3sfkLj/khAzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7928
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8728-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,siemens.com:dkim,siemens.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF326F3D51
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAxLTI5IGF0IDE1OjMwICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gVGhpcyByZXNv
bHZlcyB0aGUgZm9sbG93IHNwbGF0IGFuZCBsb2NrLXVwIHdoZW4gcnVubmluZyB3aXRoIFBSRUVN
UFRfUlQNCj4gZW5hYmxlZCBvbiBIeXBlci1WOg0KPiANCj4gWyAgNDE1LjE0MDgxOF0gQlVHOiBz
Y2hlZHVsaW5nIHdoaWxlIGF0b21pYzogc3RyZXNzLW5nLWlvbWl4LzEwNDgvMHgwMDAwMDAwMg0K
PiBbICA0MTUuMTQwODIyXSBJTkZPOiBsb2NrZGVwIGlzIHR1cm5lZCBvZmYuDQo+IFsgIDQxNS4x
NDA4MjNdIE1vZHVsZXMgbGlua2VkIGluOiBpbnRlbF9yYXBsX21zciBpbnRlbF9yYXBsX2NvbW1v
biBpbnRlbF91bmNvcmVfZnJlcXVlbmN5X2NvbW1vbiBpbnRlbF9wbWNfY29yZSBwbXRfdGVsZW1l
dHJ5IHBtdF9kaXNjb3ZlcnkgcG10X2NsYXNzIGludGVsX3BtY19zc3JhbV90ZWxlbWV0cnkgaW50
ZWxfdnNlYyBnaGFzaF9jbG11bG5pX2ludGVsIGFlc25pX2ludGVsIHJhcGwgYmluZm10X21pc2Mg
bmxzX2FzY2lpIG5sc19jcDQzNyB2ZmF0IGZhdCBzbmRfcGNtIGh5cGVydl9kcm0gc25kX3RpbWVy
IGRybV9jbGllbnRfbGliIGRybV9zaG1lbV9oZWxwZXIgc25kIHNnIHNvdW5kY29yZSBkcm1fa21z
X2hlbHBlciBwY3Nwa3IgaHZfYmFsbG9vbiBodl91dGlscyBldmRldiBqb3lkZXYgZHJtIGNvbmZp
Z2ZzIGVmaV9wc3RvcmUgbmZuZXRsaW5rIHZzb2NrX2xvb3BiYWNrIHZtd192c29ja192aXJ0aW9f
dHJhbnNwb3J0X2NvbW1vbiBodl9zb2NrIHZtd192c29ja192bWNpX3RyYW5zcG9ydCB2c29jayB2
bXdfdm1jaSBlZml2YXJmcyBhdXRvZnM0IGV4dDQgY3JjMTYgbWJjYWNoZSBqYmQyIHNyX21vZCBz
ZF9tb2QgY2Ryb20gaHZfc3RvcnZzYyBzZXJpb19yYXcgaGlkX2dlbmVyaWMgc2NzaV90cmFuc3Bv
cnRfZmMgaGlkX2h5cGVydiBzY3NpX21vZCBoaWQgaHZfbmV0dnNjIGh5cGVydl9rZXlib2FyZCBz
Y3NpX2NvbW1vbg0KPiBbICA0MTUuMTQwODQ2XSBQcmVlbXB0aW9uIGRpc2FibGVkIGF0Og0KPiBb
ICA0MTUuMTQwODQ3XSBbPGZmZmZmZmZmYzA2NTYxNzE+XSBzdG9ydnNjX3F1ZXVlY29tbWFuZCsw
eDJlMS8weGJlMCBbaHZfc3RvcnZzY10NCj4gWyAgNDE1LjE0MDg1NF0gQ1BVOiA4IFVJRDogMCBQ
SUQ6IDEwNDggQ29tbTogc3RyZXNzLW5nLWlvbWl4IE5vdCB0YWludGVkIDYuMTkuMC1yYzcgIzMw
IFBSRUVNUFRfe1JULChmdWxsKX0NCj4gWyAgNDE1LjE0MDg1Nl0gSGFyZHdhcmUgbmFtZTogTWlj
cm9zb2Z0IENvcnBvcmF0aW9uIFZpcnR1YWwgTWFjaGluZS9WaXJ0dWFsIE1hY2hpbmUsIEJJT1Mg
SHlwZXItViBVRUZJIFJlbGVhc2UgdjQuMSAwOS8wNC8yMDI0DQo+IFsgIDQxNS4xNDA4NTddIENh
bGwgVHJhY2U6DQo+IFsgIDQxNS4xNDA4NjFdICA8VEFTSz4NCj4gWyAgNDE1LjE0MDg2MV0gID8g
c3RvcnZzY19xdWV1ZWNvbW1hbmQrMHgyZTEvMHhiZTAgW2h2X3N0b3J2c2NdDQo+IFsgIDQxNS4x
NDA4NjNdICBkdW1wX3N0YWNrX2x2bCsweDkxLzB4YjANCj4gWyAgNDE1LjE0MDg3MF0gIF9fc2No
ZWR1bGVfYnVnKzB4OWMvMHhjMA0KPiBbICA0MTUuMTQwODc1XSAgX19zY2hlZHVsZSsweGRmNi8w
eDEzMDANCj4gWyAgNDE1LjE0MDg3N10gID8gcnRsb2NrX3Nsb3dsb2NrX2xvY2tlZCsweDU2Yy8w
eDE5ODANCj4gWyAgNDE1LjE0MDg3OV0gID8gcmN1X2lzX3dhdGNoaW5nKzB4MTIvMHg2MA0KPiBb
ICA0MTUuMTQwODgzXSAgc2NoZWR1bGVfcnRsb2NrKzB4MjEvMHg0MA0KPiBbICA0MTUuMTQwODg1
XSAgcnRsb2NrX3Nsb3dsb2NrX2xvY2tlZCsweDUwMi8weDE5ODANCj4gWyAgNDE1LjE0MDg5MV0g
IHJ0X3NwaW5fbG9jaysweDg5LzB4MWUwDQo+IFsgIDQxNS4xNDA4OTNdICBodl9yaW5nYnVmZmVy
X3dyaXRlKzB4ODcvMHgyYTANCj4gWyAgNDE1LjE0MDg5OV0gIHZtYnVzX3NlbmRwYWNrZXRfbXBi
X2Rlc2MrMHhiNi8weGUwDQo+IFsgIDQxNS4xNDA5MDBdICA/IHJjdV9pc193YXRjaGluZysweDEy
LzB4NjANCj4gWyAgNDE1LjE0MDkwMl0gIHN0b3J2c2NfcXVldWVjb21tYW5kKzB4NjY5LzB4YmUw
IFtodl9zdG9ydnNjXQ0KPiBbICA0MTUuMTQwOTA0XSAgPyBIQVJESVJRX3ZlcmJvc2UrMHgxMC8w
eDEwDQo+IFsgIDQxNS4xNDA5MDhdICA/IF9fcnFfcW9zX2lzc3VlKzB4MjgvMHg0MA0KPiBbICA0
MTUuMTQwOTExXSAgc2NzaV9xdWV1ZV9ycSsweDc2MC8weGQ4MCBbc2NzaV9tb2RdDQo+IFsgIDQx
NS4xNDA5MjZdICBfX2Jsa19tcV9pc3N1ZV9kaXJlY3RseSsweDRhLzB4YzANCj4gWyAgNDE1LjE0
MDkyOF0gIGJsa19tcV9pc3N1ZV9kaXJlY3QrMHg4Ny8weDJiMA0KPiBbICA0MTUuMTQwOTMxXSAg
YmxrX21xX2Rpc3BhdGNoX3F1ZXVlX3JlcXVlc3RzKzB4MTIwLzB4NDQwDQo+IFsgIDQxNS4xNDA5
MzNdICBibGtfbXFfZmx1c2hfcGx1Z19saXN0KzB4N2EvMHgxYTANCj4gWyAgNDE1LjE0MDkzNV0g
IF9fYmxrX2ZsdXNoX3BsdWcrMHhmNC8weDE1MA0KPiBbICA0MTUuMTQwOTQwXSAgX19zdWJtaXRf
YmlvKzB4MmIyLzB4NWMwDQo+IFsgIDQxNS4xNDA5NDRdICA/IHN1Ym1pdF9iaW9fbm9hY2N0X25v
Y2hlY2srMHgyNzIvMHgzNjANCj4gWyAgNDE1LjE0MDk0Nl0gIHN1Ym1pdF9iaW9fbm9hY2N0X25v
Y2hlY2srMHgyNzIvMHgzNjANCj4gWyAgNDE1LjE0MDk1MV0gIGV4dDRfcmVhZF9iaF9sb2NrKzB4
M2UvMHg2MCBbZXh0NF0NCj4gWyAgNDE1LjE0MDk5NV0gIGV4dDRfYmxvY2tfd3JpdGVfYmVnaW4r
MHgzOTYvMHg2NTAgW2V4dDRdDQo+IFsgIDQxNS4xNDEwMThdICA/IF9fcGZ4X2V4dDRfZGFfZ2V0
X2Jsb2NrX3ByZXArMHgxMC8weDEwIFtleHQ0XQ0KPiBbICA0MTUuMTQxMDM4XSAgZXh0NF9kYV93
cml0ZV9iZWdpbisweDFjNC8weDM1MCBbZXh0NF0NCj4gWyAgNDE1LjE0MTA2MF0gIGdlbmVyaWNf
cGVyZm9ybV93cml0ZSsweDE0ZS8weDJjMA0KPiBbICA0MTUuMTQxMDY1XSAgZXh0NF9idWZmZXJl
ZF93cml0ZV9pdGVyKzB4NmIvMHgxMjAgW2V4dDRdDQo+IFsgIDQxNS4xNDEwODNdICB2ZnNfd3Jp
dGUrMHgyY2EvMHg1NzANCj4gWyAgNDE1LjE0MTA4N10gIGtzeXNfd3JpdGUrMHg3Ni8weGYwDQo+
IFsgIDQxNS4xNDEwODldICBkb19zeXNjYWxsXzY0KzB4OTkvMHgxNDkwDQo+IFsgIDQxNS4xNDEw
OTNdICA/IHJjdV9pc193YXRjaGluZysweDEyLzB4NjANCj4gWyAgNDE1LjE0MTA5NV0gID8gZmlu
aXNoX3Rhc2tfc3dpdGNoLmlzcmEuMCsweGRmLzB4M2QwDQo+IFsgIDQxNS4xNDEwOTddICA/IHJj
dV9pc193YXRjaGluZysweDEyLzB4NjANCj4gWyAgNDE1LjE0MTA5OF0gID8gbG9ja19yZWxlYXNl
KzB4MWYwLzB4MmEwDQo+IFsgIDQxNS4xNDExMDBdICA/IHJjdV9pc193YXRjaGluZysweDEyLzB4
NjANCj4gWyAgNDE1LjE0MTEwMV0gID8gZmluaXNoX3Rhc2tfc3dpdGNoLmlzcmEuMCsweGU0LzB4
M2QwDQo+IFsgIDQxNS4xNDExMDNdICA/IHJjdV9pc193YXRjaGluZysweDEyLzB4NjANCj4gWyAg
NDE1LjE0MTEwNF0gID8gX19zY2hlZHVsZSsweGIzNC8weDEzMDANCj4gWyAgNDE1LjE0MTEwNl0g
ID8gaHJ0aW1lcl90cnlfdG9fY2FuY2VsKzB4MWQvMHgxNzANCj4gWyAgNDE1LjE0MTEwOV0gID8g
ZG9fbmFub3NsZWVwKzB4OGIvMHgxNjANCj4gWyAgNDE1LjE0MTExMV0gID8gaHJ0aW1lcl9uYW5v
c2xlZXArMHg4OS8weDEwMA0KPiBbICA0MTUuMTQxMTE0XSAgPyBfX3BmeF9ocnRpbWVyX3dha2V1
cCsweDEwLzB4MTANCj4gWyAgNDE1LjE0MTExNl0gID8geGZkX3ZhbGlkYXRlX3N0YXRlKzB4MjYv
MHg5MA0KPiBbICA0MTUuMTQxMTE4XSAgPyByY3VfaXNfd2F0Y2hpbmcrMHgxMi8weDYwDQo+IFsg
IDQxNS4xNDExMjBdICA/IGRvX3N5c2NhbGxfNjQrMHgxZTAvMHgxNDkwDQo+IFsgIDQxNS4xNDEx
MjFdICA/IGRvX3N5c2NhbGxfNjQrMHgxZTAvMHgxNDkwDQo+IFsgIDQxNS4xNDExMjNdICA/IHJj
dV9pc193YXRjaGluZysweDEyLzB4NjANCj4gWyAgNDE1LjE0MTEyNF0gID8gZG9fc3lzY2FsbF82
NCsweDFlMC8weDE0OTANCj4gWyAgNDE1LjE0MTEyNV0gID8gZG9fc3lzY2FsbF82NCsweDFlMC8w
eDE0OTANCj4gWyAgNDE1LjE0MTEyN10gID8gaXJxZW50cnlfZXhpdCsweDE0MC8weDdlMA0KPiBb
ICA0MTUuMTQxMTI5XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQ0K
PiANCj4gZ2V0X2NwdSgpIGRpc2FibGVzIHByZWVtcHRpb24gd2hpbGUgdGhlIHNwaW5sb2NrIGh2
X3JpbmdidWZmZXJfd3JpdGUgaXMNCj4gdXNpbmcgaXMgY29udmVydGVkIHRvIGFuIHJ0LW11dGV4
IHVuZGVyIFBSRUVNUFRfUlQuDQoNClRlc3RlZC1ieTogRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFu
LmJlemRla2FAc2llbWVucy5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2Eg
PGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IC0tLQ0KDQpUaGlzIHBhdGNoIHN1cnZpdmVkIGEg
MjRoIHN0cmVzcyB0ZXN0IHdpdGggQ09ORklHX1BSRUVNUFRfUlQgZW5hYmxlZCBhbmQNCmhlYXZ5
IGxvYWQgYXBwbGllZCB0byB0aGUgc3lzdGVtLg0KDQpXaXRob3V0IHRoaXMgcGF0Y2ggLSBhbmQg
dmVyeSBzYW1lIHN5c3RlbSBjb25maWd1cmF0aW9uIC0gdGhlIHN5c3RlbQ0Kd2lsbCBsb2NrIHVw
IHdpdGhpbiAyIG1pbnV0ZXMuDQoNCkJlc3QgcmVnYXJkcywNCkZsb3JpYW4NCg0KLS0gDQpTaWVt
ZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQoN
Cg0K

