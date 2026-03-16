Return-Path: <linux-hyperv+bounces-9450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPRqOpJtuGn5dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9450-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 21:52:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8B2A0660
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4783055C4E
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC8359A91;
	Mon, 16 Mar 2026 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WWAorRGi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022132.outbound.protection.outlook.com [52.101.53.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819B359A76;
	Mon, 16 Mar 2026 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694251; cv=fail; b=P0EUZC3UOyrAUmfUa0TpxzvyEeTxlbjoCldj9NzBbO0fBBr1fpVpa7k8OGxRbZ1f1ZXd5b5oPGdHwhFqqKspY0coAPAi+IqFnKLZnIKPdo8/GMQfFb2a4U0CHulo+sbcvs7fbtJx+Wqo2oKiyPJPh+y0EynmVQTSso0cZcrFEPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694251; c=relaxed/simple;
	bh=sMggQiDntDgEpB/gWifQl0yLyQdrlCqP1nnlbD+vOyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pCJo5R3jN96AOrkXiyFz4MWCiH0KXX4Z63drY4HXv+sOSJ3c+Z3/ns9B6xwOwzeck3XUDtDibDWyCV1ffEb77z5cKa4oH/bih+ApZ37Ch6kAkgzZGgiVTluzant5zfUDLQnbloY9JcMK9TNbNUoC/AXTI51ydpmINy32+32BvwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WWAorRGi; arc=fail smtp.client-ip=52.101.53.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANNI6Fh1yRr3uenQZc0Ph7TIeyVGhHQZW3ZkfqMNqyABEotrE/XwtAyn3W/VJYBUtbX1t5tY8cCXzdgxx2xoCn8BOIxIqP+Stg2DcUtllLDC1pZv3Ag8zNO8msHCuXrrTTWIsR8/VvdtTRzdbs3M/EL1llWHBFFwjH/9bBdoqwilu++j2JtmTo+y/ovRj0pa3WRAqp3PM4detpNaHp3nD40hjpgK+0U7S4UPEkPuvofOhtw/HE+oQcoT2/T9KXy1maJRuEWqgK4sI9RVJodIzM0cVFrga360TmXjdLVjzrm6aZGJlOKY2RJ1BndGMEswxCWiQjdsOKVqz2+lHbiQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMggQiDntDgEpB/gWifQl0yLyQdrlCqP1nnlbD+vOyg=;
 b=S0QbxoEOUhrLDpvIud4MVTpd7aeqODeLUafZiFAQNHgNNdrA9NLoj/zZoaEAuX2C76i7Wfpc3Qwr1iOqcsmBZqBbLEdwR3QJaB+BEdIgbhuYgy9pRabvK77W90gNsDVQWUHbuO+AGKpDsXIyW86nJYQ/o5RZ2a4q/rtSo4o9lb4W6vDVoh+5aZQHMT/cDPpbjPKy8Xw+o8wdgLNnRSKgXkwefB67PGLow09ttWW7gBfMa1hjwlOfVLnDiwEI3zTFgsLejpql6wSMR4VsYv01ncL3SofK7ptGJZy1J/vkN2oztPPv0WdMOLr+aDuivftwd4fCN5S044Ulcv82KRWdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMggQiDntDgEpB/gWifQl0yLyQdrlCqP1nnlbD+vOyg=;
 b=WWAorRGiDrj9dxNlGUAHjGCI7hfUN0kUxzInwFHxVKSd3AiijTLzAezOopoOWR/MJme3RKbt355rVQV7xdnVfh5ho6XohHVTwfYFNEJxgM2r14T4VElkVLWxagdlur3X51a9BbUWoM2tM8qrwTEw2prNAcr5FZ8zK5ieLoabc+g=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB2051.namprd21.prod.outlook.com (2603:10b6:806:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.4; Mon, 16 Mar
 2026 20:50:45 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Mon, 16 Mar 2026
 20:50:40 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Index: AQHcskxp/rldcz8WSE6y5yrJ7Ov/rrWxl2eAgAAP7gA=
Date: Mon, 16 Mar 2026 20:50:39 +0000
Message-ID:
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
In-Reply-To: <20260316194929.GI61385@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=70caf0d7-b924-4682-9185-bc34ccc1ab12;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-16T20:46:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB2051:EE_
x-ms-office365-filtering-correlation-id: 21dcbec1-a623-4e1b-ef17-08de839daee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 QOXgzZNx/kESSCRzcIWW5scmnsonPyNHIPOo/WwLKGHCqh3f88osifMZaPCeRY7XS1bIYUc2lhI/8iOk/I422domD2icMQZXM0MVIaGVrVo0u/LX/a5+i3NaL/ZOBgtPsBvP8kxH9Z8q5f3RYtRsy8YmoqLMtp+TSA6WxN0j4+okjFzbHsRuAV0ZFeZomz6AqOBSm+Do8Yi0QWmuBzsXgnymfQIbSiqwG8tdt7iimwQkjjR5ab5N+Gyc0+AzO8sFTENlHl1wXwxDUg1vP97WEGGQXwycbTW5iJLzHR9zCr7Opkgmqi8quBsUGHsS6n7+Z208OeLRvcTlNQGazftvNJdSgPigtJeYP+JcDW4S1j7TELvYbxqmvdzQbRcR9QAWRCvTCZAHiaqYkmBJWooiuk5tKR4MbPAIMMxoBd6ewyE9IAYMEFNX2pbDpmdtPVgqj9bJrPgj3FKa6VtKA/tQIOMOCLMaMgxu7RifJLav5hHyp6TafmiAGaxSbrdt2DeF2q6j2gCQgNvZ0m/QFnjuF+ixIqLLEThDeCnUsNZLTfIfnlCH4PVHjtMsh9EDJBJWFk4zaIlNV3NenphiS4h4mZLzx4Dqyhhpb+o3WGS2AGwq84D4EtdoHrIa2KU/x1g97RhniCrNTI5ERXtNnSpBZOfT7vZBc5OBv4dpgkKeDeDGuA7J3vK2otOziu8qmKewZHCmbor/oi5PPCgiZS8qlSs6syMNQezUKU4A7gAxMDSGzHxvM94ovbrAMA8OUyLjkp1Dso8QqdzhKnNIrP8FHVRbLQaPwslpo7q+qh3zXQs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFU3aCtHZXd5bmVJKzNWbEpFelFLM0JPUmFTZ2pMc21hU2E2YkxyaStKcHph?=
 =?utf-8?B?Z3hMMmR4YXl6YUhPSDZzWW1JUHhqOE1VK3hDMjJjdHhaMGxiMmhhRUZQd05a?=
 =?utf-8?B?bGJLcGtUTWNndDRFcjBEd2pUUEJ2OWFUcm9QSHJUZ21xc2pCd2hRYUNIaVlR?=
 =?utf-8?B?RVFsSEo4QzVoZ3BZNXluVjdZei9KMEx1V0grSVhWZEJwRHdQR25ZdmJnem5J?=
 =?utf-8?B?QlAzSThzVU0yRGc1T3l0bk9IbGFIRC8wOEo1Y1Rycm5aMHVWV1g5TlYzbTdM?=
 =?utf-8?B?QzAxR1ZMeUZ3SEdrSEE5cDhwWG1EN3ZXQXFZWDdKQjJsL3YvZ2pCOFRndHE2?=
 =?utf-8?B?WUhiR05UZE5tWWo5YnBzWDdiQXJIcitwT1ZMM3RQSVpTbndpcjRqbnVYMXpE?=
 =?utf-8?B?dWJuL3ZtL2RuMk1kUEJyd2NkYWphNHBEazJCQkw2cmNGUExjQjJaSnlKcHF6?=
 =?utf-8?B?azFvUml5Q1AwVWw1aVlRdW9FczZ4Z3BBUlJvYzlUanBlVUF5OXRCb2lHaGhU?=
 =?utf-8?B?SHZhVE85SkN2TzVlVjNpWC9LREdrR010bG1scFZucXhuZDM0QW10TDFLNUdX?=
 =?utf-8?B?V1dBWnBYSjZoSEdZMlZrU1loalRRYXdPamM4bzdmdjZCODlOOU50WHZibUdZ?=
 =?utf-8?B?bGUrUjJqWEo5bGdHYVl5cC9FSzFFalR1bFkxWGtSalR0cmRxMUNVTUY2K3FR?=
 =?utf-8?B?dENyU1J2UURlblVEV0JEbHV0NWx4N0wzMm91VlhiWnJtZmtGbmM0YVhBUHV4?=
 =?utf-8?B?cXpjSzdJb0dNUFliRGx1UVBjT01wYjMwWGlmMHVkMjRqbnVDb0NRb2thYzF2?=
 =?utf-8?B?QVNGQytoS2d2V2RXMGhrZTVHdVVHTkxscFJYLytkZDNiaTlwQ2xHWlJUUTI2?=
 =?utf-8?B?U2RLdDNST1hlNFNLZXJSeld2OHlabE9PTVgvVGdkcmptdm5uUTlRT2U3K0tI?=
 =?utf-8?B?ZTF6amFJajRFeUJaTzR5My84VUEwN0o3MEE4NG5BT2ZYNERaVXBIRFBmakJk?=
 =?utf-8?B?N01qeHQxUytodjRFbVpvSlNqQ0xEQnRja3BHd3MrMnFWZGxqMm9pc2RxMTNa?=
 =?utf-8?B?OStvS0dGbTg1U0lyWmYzWmYyWnBFdHZZbXdxOEE0VWhhQWZTUWZhVUJwWDRZ?=
 =?utf-8?B?QVozQko2S0luc0gwaGpUdHBaREpReFJRVGtEaXExNlh6TTdpOExkSkxJVVBB?=
 =?utf-8?B?TDMveU9vSDlEeUNYaGJGbUlDUHgzT1c3NVlvMDNvMWJsdXhIaVl4THl6S0hj?=
 =?utf-8?B?Z0pxb0E2TnlxU0V2NkNQQWN0d21jNWtuUDk0SzVrY3NUVlpkTTdUY00wZ3RW?=
 =?utf-8?B?SEhHbVRzcDd5Y1Z6UDdFbVNHZUdSMjhHQkhUc2tIajNaWkxHb3RscTVhVkkw?=
 =?utf-8?B?N3l0anE5UGw2cktQdEg4RUkyWVFyYUJxT3kxSmkzR09ibXgzZUhERldGL3VS?=
 =?utf-8?B?OXNVT1UyOVlnb2N2SGF4amdnckR4S2RxSHY1bG1na0I1RUdYTkZHeHAvdHc0?=
 =?utf-8?B?WnhPeXZqWFZOUUY5NWh0NW9qUzNjNUc3UmdhZUFka29YTlFnMXB6SDh3QklN?=
 =?utf-8?B?eEt0eXRURVJJOTQrTGRteTg3RzVNYmF4dGZ1TU5MM1p6RC95aXdpUTAzNEtl?=
 =?utf-8?B?RXBEL1cvYmNiQjRDTFBxYWJoRE9iWHRQQ1dVcXM1NlVDYkFiVENVVHdRMFR1?=
 =?utf-8?B?aUlROFdpTXozekNSSHFiZEptTzI1SmNMUGc5a1VNejNGZjlreDVRbHdjazA2?=
 =?utf-8?B?VDRrMnRtQkhyTEFqWVljdmY3MVlVS0x5bUlHUlZwK2tvYWFSL1IvRzk5MEZN?=
 =?utf-8?B?S2E5Q3lsS1g2a2RkT2wrQmtCcENqelpDR3lQelp0OW9tZTNRamhJWERtdzNi?=
 =?utf-8?B?T1JXMTFiRTZ6eGJaaXVWTDJNNFExYWoyN1M0cXhSV1NjTHBlUlZFWlR3aXFl?=
 =?utf-8?B?d0ZNVmpCbGVQQ0RQb3NZWEh2c3dnbHQ3SHQ0SHBJdmhNcTFiWU1TRUt4bXpV?=
 =?utf-8?B?WENWZXg0Vm8zNmdmdFJxOVppNEgya3pkTk1NbHl2RmRoVkc4R05iWEdKNzJZ?=
 =?utf-8?B?dkwyWStTd1d3bmR6QlUwSWNKRE85aFB1Q0JoOEZwY3VFY09hSmNwYmd3b2pm?=
 =?utf-8?B?T0JSUWM1VzZUVEduVDhzYWEwcGU1R2p1bGptUVp5b2hwSklHUFU2VkRuZGty?=
 =?utf-8?B?M0NiZ2Q3Q1hKTWZoZkZjUWdQa1hUQmUydThFM215cHptcENsZFg5cThiU1Bp?=
 =?utf-8?B?WFZqaXFGblZ6RXNvRGFjUzNqMWhYOU5mZEJrbE0yR3pTc25jazBkbHgxSUxG?=
 =?utf-8?Q?tLdT4yvkduFF6Jsp25?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dcbec1-a623-4e1b-ef17-08de839daee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 20:50:39.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmkvYjFEVvDNJGYOeBBf06L60MMK9AO1zKaBbLjp+O5TyRK2e5t0Jpr3cq/A6WGvbiDuBC+mTuHF/6Q69OoJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2051
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9450-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 47F8B2A0660
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBUaHUsIE1hciAxMiwgMjAyNiBhdCAxMToxNjo0MUFNIC0wNzAwLCBFcm5pIFNyaSBTYXR5
YSBWZW5uZWxhIHdyb3RlOg0KPiA+IEFzIHBhcnQgb2YgTUFOQSBoYXJkZW5pbmcgZm9yIENWTSwg
Y2xhbXAgaGFyZHdhcmUtcmVwb3J0ZWQgYWRhcHRlcg0KPiA+IGNhcGFiaWxpdHkgdmFsdWVzIGZy
b20gdGhlIE1BTkFfSUJfR0VUX0FEQVBURVJfQ0FQIHJlc3BvbnNlIGJlZm9yZQ0KPiA+IHRoZXkg
YXJlIHVzZWQgYnkgdGhlIElCIHN1YnN5c3RlbS4NCj4gPg0KPiA+IFRoZSByZXNwb25zZSBmaWVs
ZHMgKG1heF9xcF9jb3VudCwgbWF4X2NxX2NvdW50LCBtYXhfbXJfY291bnQsDQo+ID4gbWF4X3Bk
X2NvdW50LCBtYXhfaW5ib3VuZF9yZWFkX2xpbWl0LCBtYXhfb3V0Ym91bmRfcmVhZF9saW1pdCwN
Cj4gPiBtYXhfcXBfd3IsIG1heF9zZW5kX3NnZV9jb3VudCwgbWF4X3JlY3Zfc2dlX2NvdW50KSBh
cmUgdTMyIGJ1dCBhcmUNCj4gPiBhc3NpZ25lZCB0byBzaWduZWQgaW50IG1lbWJlcnMgaW4gc3Ry
dWN0IGliX2RldmljZV9hdHRyLiBJZiBoYXJkd2FyZQ0KPiA+IHJldHVybnMgYSB2YWx1ZSBleGNl
ZWRpbmcgSU5UX01BWCwgdGhlIGltcGxpY2l0IHUzMi10by1pbnQgY29udmVyc2lvbg0KPiA+IHBy
b2R1Y2VzIGEgbmVnYXRpdmUgdmFsdWUsIHdoaWNoIGNhbiBjYXVzZSBpbmNvcnJlY3QgYmVoYXZp
b3IgaW4gdGhlDQo+ID4gSUIgY29yZSBhbmQgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucy4NCj4gDQo+
IFRoaXMgc2VudGVuY2UgZG9lcyBub3QgbWFrZSBzZW5zZSBpbiB0aGUgY29udGV4dCBvZiB0aGUg
TGludXgga2VybmVsLg0KPiBUaGUgZnVuZGFtZW50YWwgYXNzdW1wdGlvbiBpcyB0aGF0IHRoZSB1
bmRlcmx5aW5nIGhhcmR3YXJlIGJlaGF2ZXMgY29ycmVjdGx5LA0KPiBhbmQgZHJpdmVyIGNvZGUg
c2hvdWxkIG5vdCBhdHRlbXB0IHRvIGd1YXJkIGFnYWluc3QgcHVyZWx5IGh5cG90aGV0aWNhbA0K
PiBmYWlsdXJlcy4gVGhlIGtlcm5lbCBvbmx5IGltcGxlbWVudHMgc3VjaCBzZWxm4oCRcHJvdGVj
dGlvbiB3aGVuIHRoZXJlIGlzIGENCj4gZG9jdW1lbnRlZCBoYXJkd2FyZSBpc3N1ZSBhY2NvbXBh
bmllZCBieSBvZmZpY2lhbCBlcnJhdGEuDQo+IA0KPiBUaGFua3MNCg0KVGhlIGlkZWEgaXMgdGhh
dCBhIG1hbGljaW91cyBoYXJkd2FyZSBjYW4ndCBjb3JydXB0IGFuZCBzdGVhbCBvdGhlciBkYXRh
IGZyb20gdGhlIGtlcm5lbC4NCg0KVGhlIGFzc3VtcHRpb24gaXMgdGhhdCBpbiBhIHB1YmxpYyBj
bG91ZCBlbnZpcm9ubWVudCwgeW91IGNhbid0IHRydXN0IHRoZSBoYXJkd2FyZSAxMDAlLg0K

