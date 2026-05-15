Return-Path: <linux-hyperv+bounces-10986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIEsAUqtB2q5BwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10986-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 01:33:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E65595BF
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 01:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FFBD301BCCE
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC813C76AD;
	Fri, 15 May 2026 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CzOMrBPp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013041.outbound.protection.outlook.com [52.103.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA230F957;
	Fri, 15 May 2026 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888006; cv=fail; b=QkLUmDGbpX/Ko8ltyIJsKn0Qq7Tv1lbv482PA+OLGgZQW+CWSb+JxXW3z2ZgyWUQwsEFGCQOk32xNzBNnFs88baA75oIivxVqWGy/nxE71X5LcIPg6QvHj5ltuJpfMypzbRttn4RuiCidJRUCs5QoZbcRg3zkz7qSPuwPutTYow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888006; c=relaxed/simple;
	bh=KA87gamoWf9eLcK0AQq8hCe9x1ew4SqquM1YdastrxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uzde3o3sWckLgrW9kxAUtenG7ZgZ2aV7thNn8Oidjo+uh1YcwyesUJ5N9/oMxcKOlnwqao/zqob0fzLLb4aA8A/0FMjDOXVxTIEpZdMGRg3Q0e5HTzl6DQmCS++6NhCdh+eHeJpuNe9SmzmPw9AHO+klXz7DYAVB2/ofy2tH2B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CzOMrBPp; arc=fail smtp.client-ip=52.103.14.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrrxuyXGq+FGGzTaECTgzIMR9KHfsj4qw6ve+0ZycWrBZKIkjqiF5jsQpoGYXKwBEYwDVAZ2p5TqobBdO1MmR+Djd0wJ6bstpp5xuklw3HzYo1iwY3xKxjdebsXI5tUJScOyBqJdH7qA6Dyf778QMyVI5vDcg55u9Ym+B7zaUM58+u0VEguAxA9K7SkS5tbMIak0oKPS2Rzl88ezCt+9JU8ooNH1XNd1ao/r/87zKZS/3rdj724tHzGxiucilIH9CieHBu/Ehv3BRN5BURn6RfJooa3VpJywuueHsw0X7ADPttree8LdVJml+WNM9C3UKoIyKHOHIeDKGf1lQ6sdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR7RnEA8O080sx070m0KYA9CgcQ9bLGCrfRDZRuijF4=;
 b=C5ado5bIiqyOPVLOO1qPmdzTeCmbJSffgaCz7V8HIRoOWKKmdS0yz53dTi/UpOeN4VvJZQhKkNZErrX3XBqWBemYHc4UWmCF7y6Yp4iqdIPBpKW3fAGdf4qKcvqNlwnbs6QA0tq4tpNaAXcHt7469gQSgQ31t8Fwg7/PVoagLRMy0cpklk8z22UPPTswllv9xXcbOL2nOF+oLlFVkfHjaALCvTBfol/lCGGeLWVTCXX9AlHiMbf9Koc3LGJbAOFRKT6qWSFbZno0HDpz9+/WLDQ8Wf016VROdK8dKvA49+WDZ/yRxcOYrh9B1pMn7TfLAHjyXyJSHgW4rRQvvWBOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR7RnEA8O080sx070m0KYA9CgcQ9bLGCrfRDZRuijF4=;
 b=CzOMrBPptKrbpwFX/kp/0ryyvFE+CthJ4wh/vFzock/JMq0ncP3Alfqe7wRO7zp9srQaUSOdHAoeEqckgMHlBmwLI942qXoK3NxZHpJz2GPqsgTre8SPo0z4+LqR6dxILK4ijsFdk927C/x2u1B07msfEe1K4LNFdPqZ8kaVzM44SqX8T51eN0AgVI+g1DEcJQ0JpOdp9SjwAij3nowJVBtKsieXY5DdY2mv6YN59mLY+IsAo0bDZL/IoIeMWBxawAoNTvEU+UjY9ga8io97vg6PwXglDPqwX9f/7UigQkU4EiobCuGrEF8Rpl8X59PGjxlwyLmX3kpAG89U3GwbLA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by LV0PR02MB11159.namprd02.prod.outlook.com (2603:10b6:408:330::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Fri, 15 May
 2026 23:33:22 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 23:33:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Yu Zhang
	<zhangyu1@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
	<arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQHc4WKquRiuLrUu+ESNYKKX1F+8PLYN2DNAgAFzewCAABr1EIAAXPfQ
Date: Fri, 15 May 2026 23:33:21 +0000
Message-ID:
 <BN7PR02MB4148D820AEBBBB9A1268D640D4042@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <7wil6tzqp74gdvhyjvpv47zhfernncs42wnfoueznneluz5zrp@pzr63lhy7s5f>
 <SN6PR02MB4157F7758A127AA1E8096B6CD4042@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157F7758A127AA1E8096B6CD4042@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|LV0PR02MB11159:EE_
x-ms-office365-filtering-correlation-id: 7cce64c3-73ab-4734-e8a6-08deb2da5a08
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|13091999003|41001999006|15080799012|19110799012|8062599012|8060799015|37011999003|55001999006|19101099003|31061999003|51005399006|440099028|3412199025|12091999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zhJ5HEdigO7ovfw1eK51UtOqzn5SMJbi0Tqar6ZdAgdC1NWRlRbCgI/kjd6U?=
 =?us-ascii?Q?Srqj5MqIm4py6QUnPcn/6SsYW9ckmDVzYtwMWeYgIGT8TIjqk51y0MghvYD/?=
 =?us-ascii?Q?YUYk05oF9fltJRkt5xY8JjxqyOuWu2mAR8zsLCpPm+dKWaWTcZXlIZ3AuH+7?=
 =?us-ascii?Q?ySauRch/oXhs9Tzi3QnGrn6gIVaWselATsN3smsK+W7itjy/0/5VTQBfcRQn?=
 =?us-ascii?Q?5+cQBYNhinwtu85+MFL4GoVKPuqQGG0mVHTu0LOX6afHqw4ddVVU528NJfcr?=
 =?us-ascii?Q?H2MK8bHDlOKVKJosxRz+tGROGHyE7Nc6TH9lW3NyrVA8GktgNcJeNw2/1zN5?=
 =?us-ascii?Q?V0jdzBKXfQBaJBkg2JYOZRZUztDXYAL/DbPFSWRttVI95wiOjULQeuhJ5GJ0?=
 =?us-ascii?Q?q+TQ7qABzpkGk/63ahPCXQqBxqW3qTYP3we6kU8Ay5nq3Z12xhWSoqSV1yNe?=
 =?us-ascii?Q?ckr2l0Y0od/BU1MkFX7MWPRHQUiC2I71UVo5ncSrbENZYbFMDvfOITDltzo9?=
 =?us-ascii?Q?Qg6PM/yV6Idk1rv7tDW4OlTmmFoO3LRMwW6CsudzjOM1Hz7cXIZQWBG9LyCp?=
 =?us-ascii?Q?cJl98BAGJQDeohPC6v/ZkurcYZ8ErU6RmlLdsL0X97Qcq07KgPMB3rXgPUvv?=
 =?us-ascii?Q?F/dvJRi6HQ5iyFbaEvlmvKb3wBGuAIHjnEcM15Q8RI5uKELxdiD+Bt9VABm1?=
 =?us-ascii?Q?Ajg/Bz/oR0bNIUiD2/oOWxtr8LOfzzUrvYdsAa3PnfErzPTB4pPsGNxX0FDt?=
 =?us-ascii?Q?WTrzamjkc14cDnj1LU/xzZfAJ5okSu8B6f57UN3UeUdjQ0uvyywR9qd1x+7K?=
 =?us-ascii?Q?ySxxoLFkZn9CDOtx/pUlSBgGFnaBIMgpGmAi2fJa/DBFrn71Jj6fvQCSa00V?=
 =?us-ascii?Q?Xcewjyk2lnvsJ+5Ffh6U9PdYtQlIgZkYg+wobxH5xOlXBRGbZJygzrS8mySe?=
 =?us-ascii?Q?KpNceLSfc2OJIidiU/3MUFV3vBcKCyVed+x2jNbyJ1dQtQuXV7a6DqqtZdJ5?=
 =?us-ascii?Q?65h+8+6wSgMrUkUI0ESscbj3eSEOEdeWvmFcU55L5Y6RsWkmd/GGf9Nhq2dO?=
 =?us-ascii?Q?vs4erIttziQJajhq8Imjb3yEGRmeMxTzzvJP5DHUEhVISzFFGomcgrdFxSm3?=
 =?us-ascii?Q?osKXMm82ZLpjm12x9q0h8mFg+PUseJJbrV06CwVq97sAEW985GSDxuU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xzqP4nwkh5iL2YQOx6vgsJ8Ut1ImYVXWXho21pG90EjrBYwa3wrB53SMzmhv?=
 =?us-ascii?Q?JsuS7AZbAuKlrOfNuSY9lNOAxqAg71auU5IhCYr/MssGk2NAX2pZHpO3ML+c?=
 =?us-ascii?Q?lLe3b9DFcQeCeu9N8SYynR4eMxIjZ9CSMeZIoKy5Q1s/KjTwOtIWuFhf/MTw?=
 =?us-ascii?Q?9I4rSvIdezCgmrcy2U2aQ86cnK2PpM5ENQ7cXTzHnXuxfgCrVJeg0IS2cl8K?=
 =?us-ascii?Q?GjESYIcX7kdtkTw3/XlViK7TFJg6rS6933vsbta4GfcKcEFfafuG+ByNDdfA?=
 =?us-ascii?Q?LtO9MZ854ZMZQFQK6wVeauAODRe+cmvldZ/tmEzCHAOqq3Z9ejr4QI3uAkcg?=
 =?us-ascii?Q?5Q37uQeRyEsF5hHyQqmRSPjvcX5Z7MkipeQei62gByEZD5ENYPoQo0MAYeOR?=
 =?us-ascii?Q?D3tUznpS2rg6TqWUgiVuCNNLLP98c/59X8UcCNtibmo60LZDpKqfK9UFG7Cx?=
 =?us-ascii?Q?EfhJk8e2ZtHHfaCo2ebyzdpBuyqUsYywF1qMREAdWUSOEUjKR7VUm0APgGlM?=
 =?us-ascii?Q?KyJ+Q7OIThyFyFR4rU3Sv8UDJJ+Mmk5lRKEZt2nKptVhC0o0M60cdfOm2zqQ?=
 =?us-ascii?Q?1OZ1bonca3MKgyUS+Osp4K8KZhqejU3ZpRVwFc0ZfnMuoxfFby0WDHWhSVZU?=
 =?us-ascii?Q?+CtXnLhgPMQQk+HCFVVxIYov8wHP6qYzjXeLH5IhX1ba1BJwTAwAMcBbo4Qd?=
 =?us-ascii?Q?+RaoLKCWMJhT7vCiWPb3A4eNaocUacShZzTmzdFFlUODMLnZwRyFOChC8VrI?=
 =?us-ascii?Q?repw1Vntn3E2KLhgk/Jb9IYiJRSverVGxn/iIXx64giRJ3oc4ky4WF+aAcnz?=
 =?us-ascii?Q?iZeElsNr/cxDPSUHHjXcnFvKL17IH97p5gwUy20KB+gIR7M3exeVge/DEvz2?=
 =?us-ascii?Q?UTu1BEBVjtFJfJFM3wnBCeZ7ZkfS4SwCADYgI+2NYZGPAXyc9xCM/gMAB88B?=
 =?us-ascii?Q?df6lTN8BlcY0jFo0sP1xJTwvmGurthefiYcrRMgkFbBlfsc60PfGjJAHRkWV?=
 =?us-ascii?Q?bBJ34nme36Dzjcm0giFYfMnRc418Elhyqr/ZBplUD1BuzleuEN8/QDIaSH/m?=
 =?us-ascii?Q?Vj0GeRDTc9DghG42LAP1BC2F6XpyCFe0mY1D0eok/7Bj4Qj+bnB+9Hm27n48?=
 =?us-ascii?Q?YvZVrRRFNjgsuueXtHWHoFkzW/WVD4Jvko8T+iVHXtBk2HTICeGj9mh+14bq?=
 =?us-ascii?Q?ClC0Ctmj1SRcXmbmnxBAtjLZASjYEgyDManqB1f0G9hM7JCvOWS9iBeYdarm?=
 =?us-ascii?Q?U2lEVQwao92jNFmrWBP1wRyiG6EdYB5emDyr0YHZoinILFt4qgExSYtXzfu/?=
 =?us-ascii?Q?vXnDFsitXqFv2YpPVQtoMwMVY2Oa8EZ3ZuDYO3WUavVRZTMr9xyDA0PKy+mm?=
 =?us-ascii?Q?w5O/JO8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cce64c3-73ab-4734-e8a6-08deb2da5a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 23:33:21.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11159
X-Rspamd-Queue-Id: A01E65595BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10986-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BN7PR02MB4148.namprd02.prod.outlook.com:mid,outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, May 15, 2026 11:0=
0 AM
>=20
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 =
9:24 AM
> >
> > On Thu, May 14, 2026 at 06:14:22PM +0000, Michael Kelley wrote:
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2=
026 9:24 AM
> > > >
>=20
> [....]
>=20
> > > > +	unsigned long nr_pages =3D end_pfn - start_pfn;
> > > > +	u16 count =3D 0;
> > > > +
> > > > +	while (nr_pages > 0) {
> > > > +		unsigned long flush_pages;
> > > > +		int order;
> > > > +		unsigned long pfn_align;
> > > > +		unsigned long size_align;
> > > > +
> > > > +		if (count >=3D HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > > > +			count =3D HV_IOMMU_FLUSH_VA_OVERFLOW;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		if (start_pfn)
> > > > +			pfn_align =3D __ffs(start_pfn);
> > >
> > > I don't understand why __ffs() is correct here. I would expect
> > > __fls() so it is consistent with the calculation of size_align. But I
> > > can only surmise how the hypercall works since there's no
> > > documentation, so maybe my understanding of the hypercall is
> > > wrong.   If __ffs really is correct, a comment explaining why
> > > would help. :-)
> > >
> >
> > The use of __ffs() is intentional. Each flush entry invalidates a
> > naturally aligned 2^N page block, and the hypervisor requires the
> > page_number to be aligned to 2^page_mask_shift.
> >
> > Here __ffs() and __fls() serve different purposes:
> > - __ffs(start_pfn) is about the alignment constraint, e.g.,  how
> > large a block can this address support?
> > - __fls(nr_pages) is about  the size constraint, e.g., how large
> > a block can the remaining range hold?
> >
> > Taking min() of both ensures each entry is both properly aligned
> > and within bounds.
> >
> > Thanks for raising this - it definitely deserves a comment. I had to
> > stare at it for a while myself to remember why. :)
>=20
> Hmmm. Something about this still nags at me. I'll run some
> experiments to either convince myself that you are right, or to
> come up with a counterexample.

I have resolved what was nagging at me. My understanding of how
_ffs() and __fls() work was wrong. :-(  Your code is correct.

>=20
> A related thought occurred to me. If each flush entry that is passed
> to Hyper-V describes a naturally aligned 2^N page block, I don't
> think the HV_IOMMU_MAX_FLUSH_VA_COUNT can ever
> be reached. The number of entries is limited by the number of
> bits in a PFN and the pages count, both of which are 64. And with
> 52 bit physical addressing and 4KiB pages, the actual size of
> a PFN and pages count is even smaller than 64.
> HV_IOMMU_MAX_FLUSH_VA_COUNT is the number of 8 byte
> union hv_iommu_flush_va entries that fit in a 4KiB page, so
> it's ~500.
>=20
> My statement applies to a single flush range. If multiple flush
> ranges were strung together in a single hypercall, a larger count
> could be reached, but hv_flush_device_domain_list() only does
> a single range. So I don't think the overflow case in
> hv_flush_device_domain_list() can ever happen. But let me
> do my experiments, and I will also look at this aspect to confirm
> if it's right.

My experiments also convince me that the overflow case can't
happen as long as the hypercall is being populated with entries
derived from a single range.

Michael

>=20
> >
> > > > +		else
> > > > +			pfn_align =3D BITS_PER_LONG - 1;
> > > > +
> > > > +		size_align =3D __fls(nr_pages);
> > > > +		order =3D min(pfn_align, size_align);
> > > > +		iova_list[count].page_mask_shift =3D order;
> > > > +		iova_list[count].page_number =3D start_pfn;
> > > > +
> > > > +		flush_pages =3D 1UL << order;
> > > > +		start_pfn +=3D flush_pages;
> > > > +		nr_pages -=3D flush_pages;
> > > > +		count++;
> > > > +	}
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv=
_domain,
> > > > +					struct iommu_iotlb_gather *iotlb_gather)
> > > > +{
> > > > +	u64 status;
> > > > +	u16 count;
> > > > +	unsigned long flags;
> > > > +	struct hv_input_flush_device_domain_list *input;
> > > > +
> > > > +	local_irq_save(flags);
> > > > +
> > > > +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > > +	memset(input, 0, sizeof(*input));
> > > > +
> > > > +	input->device_domain =3D hv_domain->device_domain;
> > > > +	input->flags |=3D HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> > >
> > > I would suggest moving the memset() and setting the input fields down
> > > under the "else" below so that they are parallel with the flush all c=
ase.
> > >
> >
> > I agree the structure should be more symmetric. Yet I guess the memset =
and
> > hv_iommu_fill_iova_list() need to stay before the branch since the fill
> > writes directly into input->iova_list[]. :)
>=20
> Agreed.
>=20
> >
> > > > +	count =3D hv_iommu_fill_iova_list(input->iova_list,
> > > > +					iotlb_gather->start,
> > > > +					iotlb_gather->end);
> > > > +	if (count =3D=3D HV_IOMMU_FLUSH_VA_OVERFLOW) {
> > > > +		/*
> > > > +		 * Range exceeds hypercall page capacity. Fall back to a full
> > > > +		 * domain flush.
> > > > +		 */
> > > > +		struct hv_input_flush_device_domain *flush_all =3D (void *)input=
;
> > > > +
> > > > +		memset(flush_all, 0, sizeof(*flush_all));
> > > > +		flush_all->device_domain =3D hv_domain->device_domain;
> > > > +		status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> > > > +					flush_all, NULL);
> > > > +	} else {
> > > > +		status =3D hv_do_rep_hypercall(
> > > > +				HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> > > > +				count, 0, input, NULL);
> > > > +	}
> > > > +
> > > > +	local_irq_restore(flags);
> > > > +
> > > > +	if (!hv_result_success(status))
> > > > +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed, status %lld\n", =
status);
> > >
> > > As Sashiko pointed out, a failure here can lead to all kinds of troub=
le because
> > > of leaving unflushed entries. Maybe a WARN() is more appropriate? Als=
o, maybe
> > > a failure in the list flush should try a flush all as a fallback, wit=
h the WARN()
> > > only if the flush all fails.
> > >
> >
> > Good idea. How about we restructure this routine to sth. like this:
> >
> >
> > 	memset(input, 0, sizeof(*input));
> > 	count =3D hv_iommu_fill_iova_list(...);
> >
> > 	if (count !=3D HV_IOMMU_FLUSH_VA_OVERFLOW) {
> > 		input->device_domain =3D ...;
> > 		...
> > 		status =3D hv_do_rep_hypercall(FLUSH_DEVICE_DOMAIN_LIST, ...);
> > 		if (hv_result_success(status))
> > 			goto out;
> > 	}
> >
> > 	/* overflow or list flush failed: fallback to full domain flush */
> > 	flush_all =3D (void *)input;
> > 	memset(flush_all, 0, sizeof(*flush_all));
> > 	flush_all->device_domain =3D ...;
> > 	status =3D hv_do_hypercall(FLUSH_DEVICE_DOMAIN, ...);
> > 	WARN(!hv_result_success(status), "IOTLB flush failed, status %lld\n", =
status);
> >
> > 	out:
> > 		local_irq_restore(flags);
> >
>=20
> Yes, I think this works. But per my earlier comment, if I'm right that
> the overflow case never occurs, it could be simplified further to just
> do the list flush with the full flush as the error fallback. Then WARN
> if the full flush fails.
>=20
> Michael


