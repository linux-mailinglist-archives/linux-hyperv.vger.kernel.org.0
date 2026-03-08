Return-Path: <linux-hyperv+bounces-9193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LmCOz+krWmk5QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9193-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 08 Mar 2026 17:30:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B88231134
	for <lists+linux-hyperv@lfdr.de>; Sun, 08 Mar 2026 17:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB1773004CAD
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Mar 2026 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501928C87D;
	Sun,  8 Mar 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P/TSiubZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84A2110E;
	Sun,  8 Mar 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772987450; cv=fail; b=N1Vpfq+Ao71ytla+C9Z5RoYbDNYUFDPIXRUoDUtdSJGGGh2mpGrN6+qJMt72UoBWlflNj1WoD8fbNrdzKQRGtxwVtHI0PWYGSb7hB8pMizMQekp0nmMNOW68gutlzftzGtN3xnupom88pmmxcocgGt2hos3MM/sq94WtbDZhLx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772987450; c=relaxed/simple;
	bh=wiVXezKt8bD2KVZD3/phRheQlC7edrRcaWAlC19+VM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1P4Ug8Vymkw9mdamZ72YnGvsRifcwFN/tmW4c+VkF4/rdmTEDtPG2L0DgKONIF6JTyQrGm6qT/cLx/8vohLJYc2UBvP88QFRiXeIRTyRUA0ncZVhYI+Hg3565vj9LRM2gu8J75klmkdaIkvKTR1QWlnmrTkc6UCLg6koOODnso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=P/TSiubZ; arc=fail smtp.client-ip=40.93.201.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arSOUDA7qWJZaCmR/E04cLXppm77UOXWi+JZbn4ex50unYzS5MSHvGjr8q29Mf8ev2clRBJRX5zuC6q0oKmqIaDG8m80awjU1f8wCSAQopMv0+fHlNJ1fvzNrq2msZsMqA7G2KVjtntQdYj1VK/pfTcPRqCmLDbTPkUvD8a7rOTseVyFwh6SGGfGHUDvG44ZgrVWGzFxCwN1Sb5+IlW/8fgSTmHZTXlxFiIAex/XyJU4BZRHR+J9F1va5CBYUr8CwEpZ/05NrHyWgwNfnKO3XHXMlZyJU6zN23eENR3FqDM0vUYcto8LRPMCCouk5xzUnFZDtmAizLNtryT4FPG0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKO1t+V7XaPGX6XWEpmhF70j6OV9VquJQPHs0IU5M/w=;
 b=lqWXCWTchQJuweaK8oLUXGy1Qa9NnNxvOdpIoOyv/MgjZHJE/XmXubLPaE2hA1bBBwgy8clF0bz0M0higaH2TkEv6aBXgW1WSDwKT43GQX1CJMCCnaltck2NeUkQBayXFWakXRm/FLCQlOpOEXQYfYx+T4m8MiPokiuFetlGQWfQ/PyHNJ0RsQUYVZQn0E22idwWz6+cI/jrATC01DlV82ukCmpDY8+vypaJR9jsPtlDMrMlqHUEKMTB8Armd11CtQfXRb1bUvHJCqjdWyAKv7BzhCeUYO5++9Jqf+W4q/qBIhT3ofmw/UD1/BUZbSkHnKJ7IJAYqlDu9Tonuc4ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKO1t+V7XaPGX6XWEpmhF70j6OV9VquJQPHs0IU5M/w=;
 b=P/TSiubZb6RsUEn+7x3AtxKnAJxhZV39QveFFy43ZmN1OefkBo6V4+u6Ec/ViHg2ks5OUSYujSIMcmyyLA2vTPOVRr1aigIHc8y+2hfzwrwcG3ZeklVhkZhYp3WcBAq+ma+5MwoHBidtaQCbGyqQRWHbzINhaA2HX63R+atD9Vg=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB5985.namprd21.prod.outlook.com (2603:10b6:806:4a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.1; Sun, 8 Mar
 2026 16:30:46 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9700.006; Sun, 8 Mar 2026
 16:30:20 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Dipayaan Roy
	<dipayanroy@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	Kees Cook <kees@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>, Breno
 Leitao <leitao@debian.org>, Aditya Garg <gargaditya@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH net-next,V3, 2/3] net: mana: Add support for RX CQE
 Coalescing
Thread-Topic: [PATCH net-next,V3, 2/3] net: mana: Add support for RX CQE
 Coalescing
Thread-Index: AQHcrb/rNqUY2+Q6QUGP6LNjJqxpubWk1Ykw
Date: Sun, 8 Mar 2026 16:30:20 +0000
Message-ID:
 <SA3PR21MB386734CCBFD52E5FF2C4D8D7CA78A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260306231936.549499-1-haiyangz@linux.microsoft.com>
 <20260306231936.549499-3-haiyangz@linux.microsoft.com>
In-Reply-To: <20260306231936.549499-3-haiyangz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3f25f8a-4caf-47df-9cbe-a049b12bcbaf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-08T16:27:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB5985:EE_
x-ms-office365-filtering-correlation-id: fdbef781-f861-448d-20a7-08de7d2ffdab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|38070700021|921020;
x-microsoft-antispam-message-info:
 DTnIqNagYjWwF24JzVFZgALEFBMao+0iGX24zIQPbp8L5qSLyb/ejd7Wh0D9Iz68wxYPfETT5cQauaaNs9RcOduLnG1cSYs4TIoFnV8y8aI6ZNv9o/9gr7K4T9E9U+y8g1lETMjJ4XaiXI4OiOIlroYRMRXOnLEqN8paKP/v3dWs6avYUTyq8j+eEToOS0I4L5CCr3rHaWbh1UtoQ+eV/kCDe9jp8sYrpcXgePoTDlQ14F9fxT5Z3apYjn4NuaXKqXN1th/sA1uSeU7+CU405K7wRY3aHVqtS15ttBo7fPwP3csq20xCTT/t/l5kKZ0yjAZzI7rkXDDlfj20IsOTfJCT1JwQSudmaagu/wHC2C5sG72ZR/3TuoFEW7kf914eRaYR6+Io2kgdbic0DY3slYjkMyfs3UjWnHT13Sd71iVsC+SrJuqRdlI5ToPcxeqnvoKSlXNdwyV7UezzHST2lYU5nX59NpPRJ8wdYugCQv3hZd3Nm6T1ZpyngWCBwzEo6g94mLjVW2/0mawud4PHNTzMUMAwykYwSSeHtTGSdupf2oC0JngqUZS+EWnQGbkHRQFHLV8xttnH5j8ywhVS188gZk6WZtTozyhv7P83KR8opV4Sf4EgDEqfiZk1zLTlrZ/WPih9p1yIquYdyVY919M4ryM4zob2Ao8/a7oocqoc9kyQECZHqJruXx5bITXphX5O2hJTaffZQy5i0+mCDFfPURy33cJXrbByB1nyIp1Gp1f/mLRRXFXhgTbAq5mMAu+uO/gIavLytPF1kcZPdeg1RKvPUTiQiaWSip5UWEQeIc8tJRC74qOJn1rohxxt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2EuamcZUZd0/w6KxelqLSE/lPzNibeJWVZFadIRLO5oPb9GNryLFhh6ksJLq?=
 =?us-ascii?Q?IqIjFhkIm1x/DvqMczBnVSNZ+cvEf+utjSiEM9gb9UAvf+hCWiZ77/zO43NU?=
 =?us-ascii?Q?8BodprodjugVIM7clVNCK7osxjPuflMjpERpMAgpA0Bf+EYZ1kq5+z0TnpDt?=
 =?us-ascii?Q?eJRMqwFNjAX+min/VrbT2rKvHPvEVUawPWKmV3zN9qlqfheb7hAmnHbltQTY?=
 =?us-ascii?Q?kPefy3WVfVoOdVVf5lzoLRSgTgR1Uao8BDwyFR6YZEhBJFgeh7+Z+hHVdPml?=
 =?us-ascii?Q?wujxiHOKCrprFgwoCwBLgUyoVF3PZndLBKX4yvj7GmCnMzePhcAAEPv7p2qE?=
 =?us-ascii?Q?XIFcnB/7NQmsGoxCwz1+SX9VtSN2a4dO6b9xz0ZzELFqrehB2G5dAEQZBPgj?=
 =?us-ascii?Q?cIX2D72sm6FK7qZedu/KF1m+mnEbG2oxKU4yHQ8tWdmeMqpseRU37F27ZYoE?=
 =?us-ascii?Q?eob2ifv23JlMtZQNtdTqfdO2yODjlopdU8vVB95fRu2daPfsgt6xUM3Nomfg?=
 =?us-ascii?Q?UatVjUF+gSWsYlHT58IoFW/khw23FV5DAZS79udxOa02BXjNtc8D7XWt6Bai?=
 =?us-ascii?Q?dSkVZreormvftqs0SOPg8Uq7m8ZOXyY43C523P9ccMnDTA0N7zDlEWlcQIsx?=
 =?us-ascii?Q?3CWZgG6ZEKPRJ0Jk3Se7QVYLQxIO/zHVrlc0MlP6p/ZbPXjcsGwu7RDbU9vX?=
 =?us-ascii?Q?ruoYt8AME99RjfbJfu6rOCkZfGR0brFZ5y1B4TRE0Q/sBetYFw/gQ+s1doe4?=
 =?us-ascii?Q?rqzK6KluxNwqueOeyMKD+NC7h9EKwhZWig7FWGUxXnWPtbMJYPXp9m0mHhhw?=
 =?us-ascii?Q?yOzdPL/1BB5FLy46GFrUqow2CI0Okegh7222RnIzlu8i5hqiqo/H1HwFDMgR?=
 =?us-ascii?Q?Q28BLggpxTa0YL3HjV9bdkLrnQEoxIOStflZP37rDFnHO6rZkXsXOE9Dlsc9?=
 =?us-ascii?Q?vgNnanxLH2YCzYJ+EN5nD0O59emQqVpY9mOwC9sMTx8S9sHSGT8MDUJmh1So?=
 =?us-ascii?Q?eUgv/yvG74ZnXhTissxZfk3U9XrZxEw8pjdNV7buWQPQQIHfPtRedO3cploa?=
 =?us-ascii?Q?BzmQH0NulHAw4t5JW5WUJxJHGslfAEmi3nU/PXbFmjCs9PN3mFYGS6UDXNXk?=
 =?us-ascii?Q?dPMNtDT4/k28/zm5/V3HRWv453vvcSv9mwES2ZI8BNB/A73fyF3dAfA3OUAO?=
 =?us-ascii?Q?xEprfbumUrwXN5Wrg8YygKAfE6osjkAeyRf1nOGnJs2zk8riK5H2+kKc+/iN?=
 =?us-ascii?Q?WYEjLjQoNEh0Rpj7gnHY6qsMFNYWG6AYlXwPWyRFyCEG0hzvkqjWBtOZrBN0?=
 =?us-ascii?Q?m+sTrihKsfxxFGOY/dGFWEU57Rs9MNgkwDspVEIxSac6Fo75qgyNIMjgHJge?=
 =?us-ascii?Q?+SHj0GKq8vtJsp/FklpCMI5U53McnITDPmi2RaG5Z4hArYGRIF0N2+2wujD8?=
 =?us-ascii?Q?y2l3GN3C7I9Zcb06fbCTDvtfY7u9ygesYZTBOzQN3ZHk+gT5ivkTkmKP/xHR?=
 =?us-ascii?Q?GEzPnGrWM7hXqMIlHlpBOG8nkochvTmThmna0aOi0duPbQYfoXkGgtKqG8n5?=
 =?us-ascii?Q?p8hACkhdMZwpNiFyeExSRN6WW+gaXjJKVV+0maGF9oMfB+WtBnZpaRnv5o2r?=
 =?us-ascii?Q?0ic6iVKKCKXmpl07mCl67TTOv/EFuRqZiXovXrM0gAEplUxyUXYDbq4ZzwP2?=
 =?us-ascii?Q?kWvULM1WFJED20WZTzN9fyy/tCXj4sqKzmaGRuhJ5vfhXOAWu7CC5iKrr6II?=
 =?us-ascii?Q?UEvRr8RLlQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbef781-f861-448d-20a7-08de7d2ffdab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2026 16:30:20.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6IBQJGurK46Ak3AOgCCX73hETAY8Gk6spNCw4i3h+uCnHJ8MS4f4sWmOq1zOMyxQPJIBI9l7MM3sZAT0sge0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB5985
X-Rspamd-Queue-Id: D8B88231134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9193-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Sent: Friday, March 6, 2026 6:19 PM
> To: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Konstantin
> Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>; Erni
> Sri Satya Vennela <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; Kees Cook <kees@kernel.org>; Subbaraya
> Sundeep <sbhatta@marvell.com>; Breno Leitao <leitao@debian.org>; Aditya
> Garg <gargaditya@linux.microsoft.com>; linux-kernel@vger.kernel.org;
> linux-rdma@vger.kernel.org
> Cc: Paul Rosswurm <paulros@microsoft.com>
> Subject: [PATCH net-next,V3, 2/3] net: mana: Add support for RX CQE
> Coalescing
>=20
> From: Haiyang Zhang <haiyangz@microsoft.com>

> @@ -2112,13 +2122,16 @@ static void mana_process_rx_cqe(struct mana_rxq
> *rxq, struct mana_cq *cq,
>  		++ndev->stats.rx_dropped;
>  		rxbuf_oob =3D &rxq->rx_oobs[rxq->buf_index];
>  		netdev_warn_once(ndev, "Dropped a truncated packet\n");
> -		goto drop;
>=20
> -	case CQE_RX_COALESCED_4:
> -		netdev_err(ndev, "RX coalescing is unsupported\n");
> -		apc->eth_stats.rx_coalesced_err++;
> +		mana_move_wq_tail(rxq->gdma_rq,
> +				  rxbuf_oob->wqe_inf.wqe_size_in_bu);
> +		mana_post_pkt_rxq(rxq);
>  		return;
>=20
> +	case CQE_RX_COALESCED_4:
> +		coalesced =3D true;
> +		break;
> +
>  	case CQE_RX_OBJECT_FENCE:
>  		complete(&rxq->fence_event);
>  		return;
> @@ -2130,30 +2143,36 @@ static void mana_process_rx_cqe(struct mana_rxq
> *rxq, struct mana_cq *cq,
>  		return;
>  	}
>=20
> -	pktlen =3D oob->ppi[0].pkt_len;
> +	for (i =3D 0; i < MANA_RXCOMP_OOB_NUM_PPI; i++) {
> +		pktlen =3D oob->ppi[i].pkt_len;
> +		if (pktlen =3D=3D 0) {
> +			if (i =3D=3D 0)
> +				netdev_err_once(
> +					ndev,
> +					"RX pkt len=3D0, rq=3D%u, cq=3D%u,
> rxobj=3D0x%llx\n",
> +					rxq->gdma_id, cq->gdma_id, rxq->rxobj);
> +			break;
> +		}
>=20
> -	if (pktlen =3D=3D 0) {
> -		/* data packets should never have packetlength of zero */
> -		netdev_err(ndev, "RX pkt len=3D0, rq=3D%u, cq=3D%u, rxobj=3D0x%llx\n",
> -			   rxq->gdma_id, cq->gdma_id, rxq->rxobj);
> -		return;
> -	}
> +		curr =3D rxq->buf_index;
> +		rxbuf_oob =3D &rxq->rx_oobs[curr];
> +		WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu !=3D 1);
>=20
> -	curr =3D rxq->buf_index;
> -	rxbuf_oob =3D &rxq->rx_oobs[curr];
> -	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu !=3D 1);
> +		mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
>=20
> -	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
> +		/* Unsuccessful refill will have old_buf =3D=3D NULL.
> +		 * In this case, mana_rx_skb() will drop the packet.
> +		 */
> +		mana_rx_skb(old_buf, old_fp, oob, rxq, i);
>=20
> -	/* Unsuccessful refill will have old_buf =3D=3D NULL.
> -	 * In this case, mana_rx_skb() will drop the packet.
> -	 */
> -	mana_rx_skb(old_buf, old_fp, oob, rxq);
> +		mana_move_wq_tail(rxq->gdma_rq,
> +				  rxbuf_oob->wqe_inf.wqe_size_in_bu);

I will fix this pointed out by AI review:

> The comment says "Unsuccessful refill will have old_buf =3D=3D NULL" but =
this is
> only true for the first iteration.
> Should old_buf be set to NULL at the top of the loop, before calling
> mana_refill_rx_oob()?




