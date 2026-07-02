Return-Path: <linux-hyperv+bounces-11828-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sAUNK8m2RmpZcAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11828-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 21:06:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCFE6FC63E
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 21:06:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=Y9ILAVf8;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11828-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11828-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA09300B9D8
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE63803C2;
	Thu,  2 Jul 2026 19:02:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022086.outbound.protection.outlook.com [52.101.53.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3730F526;
	Thu,  2 Jul 2026 19:02:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018949; cv=fail; b=KoFt/Mu2/ekFqbk7dgRCAQ1QzGBbFORI2xA6i4Qbl3PkickTCrEA2ZRhujnuvL5s2VBFRpBnugRSvaHf8+fSFuIm82pBB0rU2SNbap6Dbx0sWrkCXUcNZqFhjMQY8oiOrBBSPEHWOueIgDH8OL2mnToUxEQ54ef9U0wFC8VUgQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018949; c=relaxed/simple;
	bh=WXNoaLBTKd1nOFPLWFWuE5I2Z04+oP/D/vjULr4Oqx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SmXWIZu36dsFPpj0fdvmetOgMuj/ZbPZe8QuCji5D7HQ+lHq7CMGtR08WFJdc70GD4KSu5fQ+an01woFhYmQWeT2q6oFIwM6SLgggnthF0GYH0Q9mLZTe9DAfPckBSimW0qYsIDvIsuuHKb4jLFVyHaGSQmODDB/emxE68cUxrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Y9ILAVf8; arc=fail smtp.client-ip=52.101.53.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmpKyprGL05E3+i4mk2/opqjTtfjw3/aVHhuQ6JSpYqDJ69lpOkyZFNsNsopUz5kCsuKl5qFNudk01h+zgNMjO/Jt8Z8GdGH1bU+dkWTgB4M3Ip3QXC/tpSLQnBm37MraZl+/gJLQH+D03IrwfqyyIpCOy6wsLuQnFKq27YfC65HPiXHeLRk36lj6G/avtSavgDNVkaQHXGSy6IO5trADxYG/Eka2khWiT5ZiHMqzYDPElUM7VvivrUdVWdHtp/UZveHyd9x883n+Q0DIYE94cmugX77g+t5fWRYXXQRu0qVm6H4KdjYh7xLPXMnmELZ02zJCXMRoDwX8q53bqO3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXNoaLBTKd1nOFPLWFWuE5I2Z04+oP/D/vjULr4Oqx4=;
 b=TmAvCzLOFqBSg+wr8RSg3l477fUwUWfGZU+JjUq7bGwc++CaxXT7bwgJc1/niJ605utSGqaXOKXf/5dSj3RPKaxMN0Bd+3hsfNcci4OHqMcgdebnVwhG0iWHyrk/i99T8gUP4lv5xk+o6pD1wHBOkjDUH0GXpIWcLuBrGNCLB2C4byOI2tpHC2roiNua4DYCZuZhUaTnVlYNMOMzr+3uNXqqHMhvh73UlXJ81yBH429AX7ATcvgG/B0eiDl/GUiVp6y+hrHe0p0vryK5ePZfhMFvJtoq1d/qwH+xAjSN7gXzOyww8xvrX2jie+/37UkcJzFogmqq6niYpg+Sj89cGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXNoaLBTKd1nOFPLWFWuE5I2Z04+oP/D/vjULr4Oqx4=;
 b=Y9ILAVf8NfqRyxONGPUYBctWlXEgz7rFDVM6GfRS8VJwMMZ9grSJcuW1W63lWaWT7/0+4fwGtWyAhjbhflNszclsqeDSknuL7FrjMbXwgXXRCJsVatozPL+viG4qnCJA87juxDFrpEw+VVhlQvOHKvSch630J4isYn9jqfAzP/c=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6778.namprd21.prod.outlook.com (2603:10b6:806:4a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.7; Thu, 2 Jul 2026
 19:02:23 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 19:02:23 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li
	<longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>, Breno Leitao
	<leitao@debian.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4] net: mana: Add Interrupt
 Moderation support
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4] net: mana: Add Interrupt
 Moderation support
Thread-Index: AQHdCA969WS5ALD9ME+/i5UEVOMaUbZZ8UUAgACn7mA=
Date: Thu, 2 Jul 2026 19:02:23 +0000
Message-ID:
 <SA3PR21MB3867A37EDC5D800086C4F5C6CAF52@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260629213652.11682-1-haiyangz@linux.microsoft.com>
 <8906f758-27fe-4ea8-8558-6d15089372d1@redhat.com>
In-Reply-To: <8906f758-27fe-4ea8-8558-6d15089372d1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e24cc55-471a-4a21-99bc-e7b07d83dbf6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-02T18:57:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6778:EE_
x-ms-office365-filtering-correlation-id: 59281103-979f-4396-41b9-08ded86c733d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|4143699003|11063799006|56012099006|18002099003|38070700021|22082099003|921020;
x-microsoft-antispam-message-info:
 aZuMx1BMRNBPzCdCd1rBl7LMEtmUrzv1bohp7UlM9nj22GjbF0ttmtDo/SpnPJmmkUjE3/aI8j2aKohKkuF4b5N4HYxtGdwPOy1SbW2YuDEPtT7at/zOyfH7iyXHI8zCOpyhpCTUYH1IasAcCwK4+WD8SSY+87rjBgxXTOx7NnjTpFbqvFsu0sNJLsYOBtX7+sQ0xDlwQ3OON6H282ojNR5+0wRYhNyrCDWfvho8vEg9ZYzibDYNgd3CqoR1k4l7ZtgSHxLn0Ma5uip94c/qCFnT+LnMYJN16V4+t8S1n1N9LbPm8F9H2l7MJZXmiSUZX3VSB9MbUlDjAynWKycRtiRaZt1MTEVrH8cCOnnKICoBgNwLtx1BZlk6KSstLbGR0izi3VvulZbYIhYL2bBEClM9oBQpZGM+Hu/aK7xlXgem8tKNnh6ecaZM8sIpfOH3nan5BXQ2g3ryppmAgN8Mmzwe24NolRSyTDapvcR5hbb78FTdSF4NwxNCKESoCfFPfUr8JZIlt+VE05Sd0d9Mb5BCPaYrImQvKUj7U3arXTzJY0P8zZBO+sP6S99Xu/S00l+JH5NOWBjLLsfkBQvyCmVGRk0Gsu+U30cVaV9+Jz6iDVD6Mya9aMsEn6AJlib+1yDcdq4aWOXy91Y0N19zCtOnk6bA4Rxa3EtdvDmukIrmHyIjYwyLZOLelQ4c49FUs2rKU2GzfZ1x8ZkCj6WS1Ekh9mQat6nYEIz2JtGIhNupL9pK4rExNwcLish4p19I
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(38070700021)(22082099003)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0RLZGR4bGtqQllZZXY2bXRpQnBvMFVwWXRXakY4bS9xQURxejI2YWRzQVNr?=
 =?utf-8?B?eVNLYlMxcERUeThUR1VzdjZqdktsckRXRjFmeFV1OXlDZTA3aXQvMEpMVGxh?=
 =?utf-8?B?Vzk4MHlNU0JITGlUamxVV2tvdWZrY2swRi9sWFFSb2JMMWVRSTArWXJXS3Zi?=
 =?utf-8?B?cWdoM3lVc2YvU3U3YXNaWlZGVlpmUnpzZTJ0RWMvVU45ZVZMK0lQL2ljdnM2?=
 =?utf-8?B?WGVpSnhYMjNzWFE4b2VaOGRteC8wQTIrbGVtSTllanJZNUMrckM3QTVIUHVa?=
 =?utf-8?B?cXdQdS90S2V2SWlKMDBlRlY5NUwvNExnaUM2NGdpbGV3eEhJT2lmbHNDRUhF?=
 =?utf-8?B?K1dTQmY5MXBOWHU1SmdEMzBKKytGbFZDa3lONk1xdFkzMDdqUXN5MkdRcUtP?=
 =?utf-8?B?bXljNWc2aVRVcTVMZTAzOTJvVEhXK0grcFFGZnVpaXBCejVYZUk2TkZSeDlO?=
 =?utf-8?B?RExnTmVQalJJcTVnbmQ2NzFFTkxOZmhtMjFXZzBtL1VtcWcrUExIOWxvcUhL?=
 =?utf-8?B?R0xaS2dpNzVvdFV2UFdkZi9hMkdMUlJLeXFvMzd1eTVYVmRzbFFsZDN0NXM3?=
 =?utf-8?B?RnNWL0xWYjRYTSt3MUdWSGtiZGRYTG5uQ0FCek8xUGxJU1FXcGVnM1Rnanpj?=
 =?utf-8?B?cnFpNzRFWGZhaHBiRHhTcG9oNEJVbkplUUFIc20yVmRzKzRQS3BLZU5uUXA0?=
 =?utf-8?B?cXh2VDluanJLd2ZrbHBFRUgvL0JhR2ZRRHUwTEw5SXhQQlNWT3Z3cUdnMkJs?=
 =?utf-8?B?NWFzbHBsNjdIM3A5WmFqWm9KYWRmeXcxUzJEOVlpOVA3dCsvd3UvZ1RBMHZP?=
 =?utf-8?B?clJKQ29kbHBYSEphNFgrbGkrUk50MzMxeGhXOVdjcmZnWlp3WDN4bDVyWjR3?=
 =?utf-8?B?QjFSeXFFRVNhTTM3RTRVMzNlT2o2cHBqV0VrV24waUVQdHZPclJ2VUVZMk9R?=
 =?utf-8?B?SC9ZR0IxUGt6TklYUHNHVk1BWGFrSmRqOHBWTXVZNXFGTzBTaCtuZTFoeWtN?=
 =?utf-8?B?SzNmcVgxY2dqUGVDQklGd3lRVDF4aW5uc1U2Rlgxd1NTbHJRZ1VsTnlPdnpi?=
 =?utf-8?B?WHJlMUhZOUJnRkpVNWJEQVl2SXlYY1ZYejJHVW1uTGVrRzRpbFBONE5QRS9M?=
 =?utf-8?B?S3BVSWwveCtXNE9mTXdFcjk0cVZtQ1pPME4vQ0RzV3R1WVhCYUJVNkZEbTJE?=
 =?utf-8?B?NjFNY0k1cUo1MUw4WEhkMlh5UXJMcGhEcngyb0NkOHpqdEpVYm4zcmdVaEVR?=
 =?utf-8?B?QzJOWGxqc016UFFBeVJoUFFpOVlLM2QvbGJKWlFiMEV0Y3NhN0pwS241VURJ?=
 =?utf-8?B?TmZrcUlPZDV5R2tjOHBjS1U4MUhpSWxaVnJUYXF5NGp1dnhPT2djSEVPRVNP?=
 =?utf-8?B?cFBNckdmcHBmYnZuWU9qK3E0SDNEQnlXdlBWZU00SlhoM3B5TUpmR1hUQStx?=
 =?utf-8?B?NlJqMHBuNVk1aldMeWw0ZG5zWmo2a3FldHAxcTFjNEFUOHJPeDFpWU5aWUs5?=
 =?utf-8?B?WC9Ub2lPNGRaaUsycTRZQnladmJ4RFNZVG1WMURWaHRvT1FTRklVcHFmWWtn?=
 =?utf-8?B?T1BxSHNtMGl1THpLTWxmS0F2WTNMWXRFOURJb3M4UG9hRDg4cStucTljNEZh?=
 =?utf-8?B?VmpwMm1GMmtpc29QOWk5OGtNTGR4OHAyMDdVTGNJaFFaWXNYL2M0dDA4M3Zm?=
 =?utf-8?B?U2FqVWwwTS9WbEY0NDFJWjlZcDdjZVZ4Y3B5ckl1bEg4SWV1L3JlZTE1dmpM?=
 =?utf-8?B?UGhyYlhxVFhFQ29abjEvaG9ySGY3NVVROHB6L1habWZWQzIra2FhUG9KV0M1?=
 =?utf-8?B?bHVYVUpEQUEvQUU5RXpsQjFpY2duQzh6VDdSMmJwdG9KVE5wOHdnb0x0Mk1J?=
 =?utf-8?B?S2JTeWIvajdRWlR6UkdjODl1RC9pNjQ3ZmtBbkxSYndVZklJR1RrZE45TGcv?=
 =?utf-8?B?UEJvTXN2TnNMdDd0OVFaT3BhWGdwWEZ0bFJOK010c3dCRm5WTEJaMmFBY2xQ?=
 =?utf-8?B?Q3J0ZWxEeXgwV1dpUTNaV29CRkEycVByQVJXMnNHTkx1ODNxQjAxdndrU3pP?=
 =?utf-8?B?cmpjZ3lTOGJuRkRPS0pTaUt3WTZmSVJGcVpkOHhvd0hSbk5iSzZCcTdRWmU2?=
 =?utf-8?B?Z0p2dlRkNHBlZDZsc29xOGt1aEd6L2tKRkdQWWphSTJOYnVDUksyYXUweHE5?=
 =?utf-8?B?OHF2SHJEdFluNFpPVi9jekQ1aWl4ZXNDZXB1cFhnSEZGbjk4MFF4NFpOZW15?=
 =?utf-8?B?YzBRbXVkNWk1dVBQcGpiRHdSL3lHaHY3cjZFNjJzOXVxVzF1bXJ3YmNzSm82?=
 =?utf-8?B?YXBpMkhFWEsydGFJSnVzOER2dXpwcGRjMlBmOERpdFdSTExGSFNQQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59281103-979f-4396-41b9-08ded86c733d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 19:02:23.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxAUfC7H3L7qb6PkxSCwuS0wLavOyS2nREsQCVNXnGIvvnXjwnh9+aAxdBucCert1Cw41qzPT+9ngKTr7KmP+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6778
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-11828-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CCFE6FC63E

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyLCAyMDI2IDQ6NTcgQU0N
Cj4gVG86IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QGxpbnV4Lm1pY3Jvc29mdC5jb20+OyBsaW51
eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgS1kg
U3Jpbml2YXNhbg0KPiA8a3lzQG1pY3Jvc29mdC5jb20+OyBIYWl5YW5nIFpoYW5nIDxoYWl5YW5n
ekBtaWNyb3NvZnQuY29tPjsgV2VpIExpdQ0KPiA8d2VpLmxpdUBrZXJuZWwub3JnPjsgRGV4dWFu
IEN1aSA8REVDVUlAbWljcm9zb2Z0LmNvbT47IExvbmcgTGkNCj4gPGxvbmdsaUBtaWNyb3NvZnQu
Y29tPjsgQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuDQo+IE1p
bGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xl
LmNvbT47IEpha3ViDQo+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBLb25zdGFudGluIFRh
cmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPjsNCj4gU2ltb24gSG9ybWFuIDxob3Jtc0Br
ZXJuZWwub3JnPjsgRXJuaSBTcmkgU2F0eWEgVmVubmVsYQ0KPiA8ZXJuaXNAbGludXgubWljcm9z
b2Z0LmNvbT47IERpcGF5YWFuIFJveQ0KPiA8ZGlwYXlhbnJveUBsaW51eC5taWNyb3NvZnQuY29t
PjsgQWRpdHlhIEdhcmcNCj4gPGdhcmdhZGl0eWFAbGludXgubWljcm9zb2Z0LmNvbT47IEJyZW5v
IExlaXRhbyA8bGVpdGFvQGRlYmlhbi5vcmc+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBhdWwgUm9zc3d1cm0gPHBh
dWxyb3NAbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIG5l
dC1uZXh0IHY0XSBuZXQ6IG1hbmE6IEFkZCBJbnRlcnJ1cHQNCj4gTW9kZXJhdGlvbiBzdXBwb3J0
DQo+IA0KPiBPbiA2LzI5LzI2IDExOjM2IFBNLCBIYWl5YW5nIFpoYW5nIHdyb3RlOg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMN
Cj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4gPiBp
bmRleCA3NDM4ZWE2YjNmMjYuLjkzOTFlOTU2NDYwNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4gPiBAQCAtMTU5MSw2ICsx
NTkxLDkgQEAgaW50IG1hbmFfY3JlYXRlX3dxX29iaihzdHJ1Y3QgbWFuYV9wb3J0X2NvbnRleHQN
Cj4gKmFwYywNCj4gPg0KPiA+ICAJbWFuYV9nZF9pbml0X3JlcV9oZHIoJnJlcS5oZHIsIE1BTkFf
Q1JFQVRFX1dRX09CSiwNCj4gPiAgCQkJICAgICBzaXplb2YocmVxKSwgc2l6ZW9mKHJlc3ApKTsN
Cj4gPiArDQo+ID4gKwlyZXEuaGRyLnJlcS5tc2dfdmVyc2lvbiA9IEdETUFfTUVTU0FHRV9WMzsN
Cj4gPiArCXJlcS5oZHIucmVzcC5tc2dfdmVyc2lvbiA9IEdETUFfTUVTU0FHRV9WMjsNCj4gDQo+
IERvdWJsZSBjaGVja2luZyB0aGUgYWJvdmUgaXMgaW50ZW50aW9uYWw7IGl0IGZlZWxzIHN0cmFu
Z2UgdG8gbWUgdGhhdA0KPiByZXF1ZXN0IGFuZCByZXBseSB1c2UgZGlmZmVyZW50IHZlcnNpb25z
LiBQb3NzaWJseSBhIGNvbW1lbnQgZm9yIGZ1dHVyZQ0KPiBtZW1vcnkgd291bGQgbWFrZSBzZW5z
ZS4NCg0KWWVzLCBpdCdzIGludGVudGlvbmFsLiBUaGUgcmVxdWVzdCBhbmQgcmVwbHkgdmVyc2lv
bnMgY2FuIGJlIGRpZmZlcmVudC4NCkkgd2lsbCBhZGQgY29tbWVudHMuDQoNCj4gPiArDQo+ID4g
Ky8qIFRoZSBjYWxsZXIgbXVzdCB1cGRhdGUgYXBjLT5yeC90eF9kaW1fZW5hYmxlZCBiZWZvcmUg
ZGlzYWJsaW5nIGFuZA0KPiA+ICsgKiBhZnRlciBlbmFibGluZy4gQW5kIHN5bmNocm9uaXplX25l
dCgpIGJlZm9yZSBkcmFpbmluZyB0aGUgRElNIHdvcmssDQo+ID4gKyAqIHNvIHRoYXQgTkFQSSBj
YW5ub3Qgb2JzZXJ2ZSBhIHN0YWxlIGZsYWcuDQo+ID4gKyAqLw0KPiA+ICtpbnQgbWFuYV9kaW1f
Y2hhbmdlKHN0cnVjdCBtYW5hX2NxICpjcSwgYm9vbCBlbmFibGUpDQo+IA0KPiBUaGlzIGFsd2F5
cyByZXR1cm4gMCwgYW5kIHRoZSByZXR1cm4gdmFsdWUgaXMgbm90IGNoZWNrZWQgYnkgdGhlDQo+
IGNhbGxlcnM7IHJldHVybiB0eXBlIHNob3VsZCBsaWtlbGx5IGNoYW5nZWQgdG8gdm9pZA0KV2ls
bCB1cGRhdGUuDQoNClRoYW5rcywNCi0gSGFpeWFuZw0KDQo=

