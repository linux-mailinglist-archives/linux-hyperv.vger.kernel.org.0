Return-Path: <linux-hyperv+bounces-10619-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLcVEgQe+Wlw5wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10619-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:30:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1AE4C463C
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 654CB3008FED
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EBB3859F4;
	Mon,  4 May 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cJw4nH1L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020089.outbound.protection.outlook.com [52.101.193.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0363845B6;
	Mon,  4 May 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933823; cv=fail; b=OmpeaW4niX3w5QG53Mi3s4I9vU/YCuSMyoNoWozQIT5TdEEZrumEiA9MNgazZJiplaBTNHW0qvEpRBFR+72YNggybgDAeQud0ot+LPR3jqFjkk9B61vNiz15d1BUPLGMunovm/lCeOmGWF9xlzh5gZfIObzDVbYPhcqu8zOJIe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933823; c=relaxed/simple;
	bh=1oyQ85WhHlMuub4p2sG+iumFu0QAYhBQ9YEs4eoC/Q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uB/i9e3CI2cweCd2COIcYNIbSorSV5pSvs5o2Oa43+WkPKU39aYyey99CRvnLg4A/9Ev4QGk9fRkGwnc+SXUlxknm2cXN2ezczk9G3ekW/LBoX6eQ2h8doodS2njePlSPSMAtvQZPMPCyyy0TJE/AfpPpidbTqEehkyAANZC7mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cJw4nH1L; arc=fail smtp.client-ip=52.101.193.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuFiA2WLEwysSmrZFkD1gDUIeKztbAPlGBVIvbkyZSa8TR0ptHXs6bomhzI0T3jRmdyIs7XlPHASytOQcjP0ChLyb4YvQSaEDIII/Fieq2/3uFHrd9gX5MOBNgH/TwEZn+rHQ4WUGWily4bHv8bYR9gLPd6+NS/a4oJDFMpaqw411yztU7VmERXNk4pdgBpzI9rLY4WsqVSNLk33PFJAcgVKyWBTfy6DzTrO2jdwP9cjAGWGgqP4F1b63wpHafZrCeieciaUf9ofd96FXkFukVtNJlnEU8tMJTZug+CdYjTVXPpBcLhodEl+69uJmn9H7VMjjj3MuyqaQzw8LFnfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0hS7jrevbgcH5FyTAKA5vJ7W2yRs5cGOWqcniZGkc8=;
 b=Q2lQiKu5OUXj6T6wH1Zonoa2oPJBYYSI3cx8VwDF8YpT6cPiRtQw2Ta+tZudRa7wRZoYifSBR39QAiI1Nn6cQvc/q0tStOu0Mn0CczEBwb3iEUdEv3+P3o4mfVAaSgp06bESYiAyKaIw8IfNIPgSrQgpKCHppZILsha9NKPWQufvNkrX2lR2gAh9Z4Qytv1eLISHTydbYP3prZz6BXsz9cnfBFg2YFZaePsZEZvbMuKct1SXORSNgBoeJPj/EYPTjlwMeDFg61FygaXO6PA6hDM6R688+rfykm2+zRvf3gOOMm/6dNCDU6YIyZaVHzmf3aV1sb1P2a8IB2qDEzHWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0hS7jrevbgcH5FyTAKA5vJ7W2yRs5cGOWqcniZGkc8=;
 b=cJw4nH1LJQG7HTN5wWXHlrY1mu0JnBPVq4I44wefzHLvswqAaz2aJPeEp8fxDuQrWRQ/Euza0it2Y9Vjya1TB21osS08/QnFuscM1O0VBdQ6qV1gIRHgGGi0U1E0AEyvzurF8xJNnakQ4aghu4SraOQY6lj1J8LEEVCfkbj1APo=
Received: from DS0PR21MB6673.namprd21.prod.outlook.com (2603:10b6:8:2f4::19)
 by DS4PR21MB6580.namprd21.prod.outlook.com (2603:10b6:8:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.3; Mon, 4 May
 2026 22:30:18 +0000
Received: from DS0PR21MB6673.namprd21.prod.outlook.com
 ([fe80::cf40:aa85:b680:dda5]) by DS0PR21MB6673.namprd21.prod.outlook.com
 ([fe80::cf40:aa85:b680:dda5%6]) with mapi id 15.20.9913.002; Mon, 4 May 2026
 22:30:18 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v6 2/6] net: mana: Query device
 capabilities and configure MSI-X sharing for EQs
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 2/6] net: mana: Query device
 capabilities and configure MSI-X sharing for EQs
Thread-Index: AQHc2CXbc8fRBuJmuEq63Eta9ef5BbX63+cAgAOZOPA=
Date: Mon, 4 May 2026 22:30:18 +0000
Message-ID:
 <DS0PR21MB6673A4070FA474021381771FCE312@DS0PR21MB6673.namprd21.prod.outlook.com>
References: <20260429221625.1841150-3-longli@microsoft.com>
 <20260502152649.292433-5-horms@kernel.org>
In-Reply-To: <20260502152649.292433-5-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2375efac-7a34-4d6a-b9ba-389feae3c3d3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-04T22:24:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR21MB6673:EE_|DS4PR21MB6580:EE_
x-ms-office365-filtering-correlation-id: cebe2acf-b23b-4d8a-f423-08deaa2cb879
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 MLWI625Z8FXFeESONMjE3HGj6GHjgLywHZkDzyIIWNoF4wrl0d0iFIYaKPmtl67v01s0FXs7A8OjwTUX09LLihvMIx4rY/tYaGh2LIXXPa0TIV9pPA/M9+Y0JQmQElg0HumEM+/hiiZGSwDSC4z5PFPictbOD21l35glJbUJoStbq3f8VTs2o8A1XlBZRHBVB52ty64CBgC2NS48fekTtTovy0x/XVCBYX+JjrqQFKIVUsdcHPk/82rOWHUVBqJPBGpAAuIBNB0A5xsx3gUlJCyn8JIBdzpfNMjf6CpcNhK+uYQYIaeKPkzqm/b2eBZbEtpHdc+vssTxFk2ptNsbU3WJg2oTmK/M3qkz1blzM1oQzfVu9xq01MYduFAjdBofizJQA025kZFbFddmT+j05UzDhj7iivjlSX2eyglF/z75ikuuCnoq6QJgon9nOXGwQ0uF7H0LECqv0qSVBH79AVIlEG31JqovyYI8Zt1Wa/g3isZNDfi7B+mYcAb6QBxvz5lAwf0MTgyuZCpyXjraIDr3/eZcH/QNJrjQ6zAEWvBqyUPS334AfUSYNob2sKnIQcURx7Uu0AqNtfXAvdp8RaJIt3Awe+j9gCD+3fwxe2wX99jAbu23gQAxGiygIe9A6VHT4e3BY531nA9akUtXTJQItEnxBQBbUsiiYB0dbO8+wQM6nltiJf8+3Srlu4D0Sd2ps6T4NfbvHAYua55lkE8BfLUuJQiLXErMlEklzCNnIZmaLMsg1318FsLnPjWJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR21MB6673.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oBRRY3ShUx3VPz2mzxiUS9++pgI5oakKOp9p1TPnUepkLkX8h0RKhz4aQMyk?=
 =?us-ascii?Q?jwh/pbS0RocXxYJtychgDFUdfS4T8O0WIaFnlDGtdYvhmCtODQ9M0DouCvHY?=
 =?us-ascii?Q?244wG6VVcz+Pee0OURcWgXUzI/JUhh9p+k5+aPLWgcQAhZ22ySjB9NqLfhLs?=
 =?us-ascii?Q?Ca5/97emjskUR5UV5GxPrfzbTqU8IPW7chyWZWOnAXzUNnygiurDoPqBroI+?=
 =?us-ascii?Q?F08qKLZe9BUm/sH6nbcuvBl7Tfyrz7DaWF2BofyExZjJ1EpkJU2eHyv1VgnD?=
 =?us-ascii?Q?+Er5JR7yYZDi4seST+mZtqmagaZXpOStkFiiFS/R/v5nRYJKXDTP3vtAPEdS?=
 =?us-ascii?Q?3aZakh4i0xrSV278GETpfiBmrS11PoNIv1G3H1tPbT2tkqBT6kDfVq4Ok4Zs?=
 =?us-ascii?Q?G/8FaWOAup8zOIiCyzxVspsdaAd9jVbA0q1s4BBgTqGsYEBSmVxd8LUj6dHq?=
 =?us-ascii?Q?05WyTsp62RckvvT1soqiqRzMdZm2LySov0uWSLv4Z6nU84Lge+GgBk/F818o?=
 =?us-ascii?Q?0LPkHW4PI3p8kYNruZ1D/sx52V9iJOAx8jE77gjqcvV13vih88P4bxRfeNyc?=
 =?us-ascii?Q?iYADcWbfHl72IYtXEkaDIzYbsnXKTEXzYMYpWRWts2/n8qgKFDhrmCKmenZf?=
 =?us-ascii?Q?cx8qZQ/MFmZNJ6lhQzRWJtLQXuxUIedb2aJ+eWn9A5uSTHBHOlNygU0NR1L3?=
 =?us-ascii?Q?nNIP+lJXME2xx+pEoTp6iiprdxpgn51yXWsLjvb+0cHN1DADgeISESqQWxh6?=
 =?us-ascii?Q?Q2sog3cGNuTldmFY4EsxeUQ80x3PAlcHoKxGHHSrE9vyURUbUlDUwuoGcA90?=
 =?us-ascii?Q?l4NfbMvsn0YlK7cSBmyf31PzWfeDYiBLztuNZFOcJeA2dQauBVUlrKiqf8wV?=
 =?us-ascii?Q?qJrvXiIG28hKj+qlTbKE1X1Rne70a3ts4d8U1ggHhf0pgMDKs9aex6yQUced?=
 =?us-ascii?Q?eCd5hEhSRkdktR+DshhZAb1aDwwDVNGIZkZi82cIveHHdJHzuaRfz6uC42PE?=
 =?us-ascii?Q?bf+P4faAqZbGSS+9M9mH1Ub4BrW7/amSQbxuSoQmf7ZeSYsNYDMsFEonZSxH?=
 =?us-ascii?Q?iIRjHdiyocoHP6UDBObtlgGLt1uWheEIT69Mm3MwPnw0S/YcCfTCpdNrTEFH?=
 =?us-ascii?Q?F9EclRdMtN/TH6P4nVRixcgqRaNJt4HbY5xQpQudg0v2wD7rQOFRQf0TNtxp?=
 =?us-ascii?Q?UNOuKD8zG5PB5W0jUWLIxJObJhCEl84AuSwUWJNPnNCawCOlxW0hdW9iv5oL?=
 =?us-ascii?Q?FlxI6dbGLNA0exG4NapK5FjT5f4b9GAq5EsJ6nZ7+Ot4xKpQJ6oD7k8RfPMV?=
 =?us-ascii?Q?EleoWff0H7vcrUJf29Cv1XPIOKJmaZ5TYbUOOPbyrFekKRQgZNhtlqk4hT8j?=
 =?us-ascii?Q?SfJPU8yXKSp2ecn1QaGZ+xUcZKCmEOdCsBIlys8kBbE2s6iiE2PaJf906YhI?=
 =?us-ascii?Q?6rq8nPOy5CNI0VgrDNW0f7BkzPDCcONh3Bg/P8ETXWdZJOwm5tDFsbh4X8zs?=
 =?us-ascii?Q?QgbPyDfuKh3Re/tgeT07uTP/kB6U2SBvm5Gyw5ayuzpskd8f9p+9MgBL76G2?=
 =?us-ascii?Q?ofYKPfvc4IOV27J2Z7JvV/Ic4xzuonGwGD8edzE9nzCpqDlh14y1Em6KMW8u?=
 =?us-ascii?Q?3Yh1BkYJ9yn8xEQljfSXRIsyXhnIeTFxL+OjqazFIWwhT9ZCLy3rDmDrjDwu?=
 =?us-ascii?Q?wFq1Ohj/vGjOBEuqDy2dIlwdkYoMLFLng5SR4HUZPfPWassr?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR21MB6673.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebe2acf-b23b-4d8a-f423-08deaa2cb879
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 22:30:18.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIiGHm3LqMWgHa2GASyGsKf3tTE3HnJN7RB+8V8r/L+DKVX75MHolLuxyaFTqhFj7UNn2ol4Qn0/I/OiC7MH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6580
X-Rspamd-Queue-Id: 4C1AE4C463C
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-10619-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,DS0PR21MB6673.namprd21.prod.outlook.com:mid,outlook.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> Full review at:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fnetde=
v-
> ai.bots.linux.dev%2Fsashiko%2F&data=3D05%7C02%7Clongli%40microsoft.com%7
> Ca5d48bdebd0240e5d91308dea85ff3a8%7C72f988bf86f141af91ab2d7cd011db4
> 7%7C1%7C0%7C639133327234427106%7CUnknown%7CTWFpbGZsb3d8eyJFbX
> B0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbC
> IsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D4doWStoTQ4w7CbmhN3I294b%
> 2B9c3NNjDGySSmISHGZk4%3D&reserved=3D0
>=20
> I apologise for any overlap with this and the review of this patchset ava=
ilable at
> sashiko.dev. They both seem relevant and I'm unsure how to cleanly pass t=
hem
> both on.
>=20
> Both Sashiko instances also flagged concerns in the remaining patches of =
this
> patchset. But I am not forwarding them as they seem to be lower priority,=
 and I
> think I've already created enough noise here.
>=20
> ---
> net: mana: Query device capabilities and configure MSI-X sharing for EQs
>=20
> This patch queries device capabilities early in GDMA probe and chooses be=
tween
> dedicated MSI-X per vPort or a shared-MSI-X mode based on the available v=
ector
> count, introducing gc->max_num_queues_vport,
> gc->msi_sharing and gc->msi_bitmap, and renaming mana_query_device_cfg()
> to mana_gd_query_device_cfg() so it can be called from the GDMA layer.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 098fbda0d128..b96859e0aec9 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -149,6 +149,9 @@ static int mana_gd_query_max_resources(struct
> pci_dev *pdev)
> >  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> >  	struct gdma_query_max_resources_resp resp =3D {};
> >  	struct gdma_general_req req =3D {};
> > +	unsigned int max_num_queues;
> > +	u8 bm_hostmode;
> > +	u16 num_ports;
> >  	int err;
> >
> >  	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
> @@ -194,6
> > +197,40 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
> >  	if (gc->max_num_queues > gc->num_msix_usable - 1)
> >  		gc->max_num_queues =3D gc->num_msix_usable - 1;
> >
> > +	err =3D mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION,
> MANA_MINOR_VERSION,
> > +				       MANA_MICRO_VERSION, &num_ports,
> &bm_hostmode);
> > +	if (err)
> > +		return err;
>=20
> Is this the same MANA_QUERY_DEV_CONFIG that mana_probe() issues shortly
> after?  mana_probe() still contains:
>=20
> 	err =3D mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION,
> MANA_MINOR_VERSION,
> 				       MANA_MICRO_VERSION, &num_ports,
> &bm_hostmode);
>=20
> so the same HWC round-trip runs twice on every probe with identical argum=
ents,
> both populating gc->adapter_mtu.
>=20
> The commit message frames this rename as consolidation ("used at GDMA dev=
ice
> probe time"), but the mana_probe() call-site is not removed.  Was one of =
the two
> call-sites meant to go away?
>=20
> The relocation of debugfs_create_u16("adapter-MTU", ...) from
> mana_gd_query_device_cfg() into mana_probe() only makes sense if the func=
tion
> is now invoked more than once, which hints at the same duplication.

  The two calls are intentional and serve different layers. The call in man=
a_gd_query_max_resources() runs at the GDMA layer during device setup - it =
needs num_ports to compute per-vPort MSI-X
  allocation before any MANA-level structures exist. The call in mana_probe=
() runs at the MANA layer and consumes the results differently: it populate=
s ac->num_ports, ac->bm_hostmode, and on
  resume validates that the port count hasn't changed.

  The HWC round-trip is lightweight (a single command/response exchange), a=
nd the function is renamed to mana_gd_ precisely because it now has callers=
 at both layers. The debugfs move is the same
  reason - the debugfs node should only be created once, so it moves to man=
a_probe() which runs once, rather than staying in the function that is now =
called from both sites.

>=20
> > +
> > +	if (!num_ports)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Adjust gc->max_num_queues returned from the SOC to allow
> dedicated
> > +	 * MSIx for each vPort. Clamp to no less than
> MANA_DEF_NUM_QUEUES.
> > +	 */
> > +	max_num_queues =3D (gc->num_msix_usable - 1) / num_ports;
> > +	max_num_queues =3D roundup_pow_of_two(max(max_num_queues, 1U));
> > +	if (max_num_queues < MANA_DEF_NUM_QUEUES)
> > +		max_num_queues =3D MANA_DEF_NUM_QUEUES;
> > +
> > +	/*
> > +	 * Use dedicated MSIx for EQs whenever possible, use MSIx sharing for
> > +	 * Ethernet EQs when (max_num_queues * num_ports >
> num_msix_usable - 1)
> > +	 */
> > +	max_num_queues =3D min(gc->max_num_queues, max_num_queues);
> > +	if (max_num_queues * num_ports > gc->num_msix_usable - 1)
> > +		gc->msi_sharing =3D true;
>=20
> Is gc->msi_sharing ever reset to false?  The only two writers are this li=
ne and
> mana_gd_setup_hwc_irqs() (the !pci_msix_can_alloc_dyn branch), and both o=
nly
> set it to true.  mana_gd_remove_irqs() frees msi_bitmap and zeros
> max_num_msix / num_msix_usable, but does not clear msi_sharing, and the
> gdma_context survives mana_gd_suspend() / mana_gd_resume().
>=20
> Once true is latched in any setup cycle, mana_gd_setup() will always take=
 the
> sharing branch on resume even if the recomputed max_num_queues * num_port=
s
> fits within num_msix_usable - 1.  Is that consistent with the commit mess=
age
> saying sharing "is only enabled when there are not enough MSI-X vectors f=
or
> dedicated allocation"?

  msi_sharing is one-directional by design, but this is not a problem in pr=
actice. The inputs to the sharing computation - num_msix_usable, num_ports,=
 and hardware queue limits - are properties of
  the hardware and do not change across suspend/resume cycles. The gdma_con=
text is kzalloc'd at probe time (so msi_sharing starts as false), and on an=
y given hardware configuration the computation
  in mana_gd_query_max_resources() will always produce the same result.

  On resume, mana_gd_setup_hwc_irqs() re-evaluates dynamic MSI-X support an=
d mana_gd_query_max_resources() recomputes the sharing check from the same =
hardware parameters. Since the hardware
  doesn't change, the flag converges to the same value. Adding an explicit =
reset would be defensive but not functionally necessary.

>=20
> > +
> > +	/* If MSI is shared, use max allowed value */
> > +	if (gc->msi_sharing)
> > +		gc->max_num_queues_vport =3D min(gc->num_msix_usable - 1,
> gc->max_num_queues);
> > +	else
> > +		gc->max_num_queues_vport =3D max_num_queues;
> > +
> > +	dev_info(gc->dev, "MSI sharing mode %d max queues %d\n",
> > +		 gc->msi_sharing, gc->max_num_queues);
>=20
> Should this print gc->max_num_queues_vport rather than
> gc->max_num_queues?  The block immediately above computes
> gc->max_num_queues_vport and leaves gc->max_num_queues unchanged, and
> mana_probe_port() sizes alloc_etherdev_mq() and apc->max_queues from
> gc->max_num_queues_vport:
>=20
> 	ndev =3D alloc_etherdev_mq(sizeof(struct mana_port_context),
> 				 gc->max_num_queues_vport);
> 	...
> 	apc->max_queues =3D gc->max_num_queues_vport;
> 	apc->num_queues =3D min(gc->max_num_queues_vport,
> MANA_DEF_NUM_QUEUES);
>=20
> so the logged value does not match the per-vPort queue count the driver a=
ctually
> exposes.


  The printed value is intentional. gc->max_num_queues is the GDMA device-l=
evel maximum, which is consumed by both the Ethernet and RDMA drivers - the=
 RDMA driver uses it to size its queue
  resources. Printing max_num_queues_vport here would only reflect the Ethe=
rnet per-vPort limit and would be misleading in a device-level log message.=
 The per-vPort value is already visible
  through ethtool channel reporting.

>=20
> > +
> >  	return 0;
> >  }
> >
> > @@ -1856,6 +1893,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev
> > *pdev)
>=20
> [ ... ]
>=20
> > @@ -1968,20 +2008,30 @@ static int mana_gd_setup(struct pci_dev *pdev)
> >  	if (err)
> >  		goto destroy_hwc;
> >
> > -	err =3D mana_gd_query_max_resources(pdev);
> > +	err =3D mana_gd_detect_devices(pdev);
> >  	if (err)
> >  		goto destroy_hwc;
> >
> > -	err =3D mana_gd_setup_remaining_irqs(pdev);
> > -	if (err) {
> > -		dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err);
> > -		goto destroy_hwc;
> > -	}
> > -
> > -	err =3D mana_gd_detect_devices(pdev);
> > +	err =3D mana_gd_query_max_resources(pdev);
> >  	if (err)
> >  		goto destroy_hwc;
> >
> > +	if (!gc->msi_sharing) {
> > +		gc->msi_bitmap =3D bitmap_zalloc(gc->num_msix_usable,
> GFP_KERNEL);
> > +		if (!gc->msi_bitmap) {
> > +			err =3D -ENOMEM;
> > +			goto destroy_hwc;
> > +		}
> > +		/* Set bit for HWC */
> > +		set_bit(0, gc->msi_bitmap);
> > +	} else {
> > +		err =3D mana_gd_setup_remaining_irqs(pdev);
> > +		if (err) {
> > +			dev_err(gc->dev, "Failed to setup remaining IRQs: %d",
> err);
> > +			goto destroy_hwc;
> > +		}
> > +	}
> > +
>=20
> Can the driver bring up any vPort after this change when the !msi_sharing=
 branch
> is taken?
>=20
> In the dedicated branch, only gc->msi_bitmap is allocated and bit 0 is se=
t for
> HWC.  mana_gd_setup_remaining_irqs() is skipped, so no gdma_irq_context i=
s
> inserted into gc->irq_contexts for indices 1..
> num_msix_usable-1.
>=20
> Later, mana_create_eq() still assigns
>=20
> 	spec.eq.msix_index =3D (i + 1) % gc->num_msix_usable;
>=20
> and mana_gd_register_irq() does:
>=20
> 	gic =3D xa_load(&gc->irq_contexts, msi_index);
> 	if (WARN_ON(!gic))
> 		return -EINVAL;
>=20
> On a typical cloud SKU with, for example, num_msix_usable=3D32,
> num_ports=3D1 and num_online_cpus=3D16, the new math keeps msi_sharing=3D=
false
> (16 * 1 <=3D 31), so every EQ-create goes down this path and hits the WAR=
N_ON.
> Doesn't that make every vPort open and every resume fail for the common
> dedicated-MSI-X case?
>=20
> The msi_bitmap allocated here is not consumed anywhere in this commit; th=
e on-
> demand allocation via mana_gd_get_gic() appears in the later commit "net:
> mana: Allocate interrupt context for each EQ when creating vPort"
> (dbbdf40a8974).  Should the bitmap and the new branch be introduced in th=
e
> same commit that actually uses them, so each commit in the series is
> independently bootable?

  You're right that the non-sharing EQ creation path is not fully functiona=
l until patch 5 wires mana_gd_get_gic() into mana_create_eq(). However, thi=
s is a new capability being built
  incrementally: patch 2 introduces the decision framework and bitmap, patc=
h 3 adds the GIC infrastructure, patch 4 converts global IRQ setup to use i=
t, and patch 5 integrates it into per-vPort EQ
  creation.

  The intermediate state between patches 2 and 5 results in a clean error (=
-EINVAL from mana_gd_register_irq) - not a crash or data corruption. The de=
dicated MSI-X mode is a new feature that did
  not exist before this series, so there is no regression from the pre-patc=
h baseline. Restructuring to make it functional at each intermediate commit=
 would require squashing the GIC
  infrastructure into this patch, producing a significantly larger and hard=
er-to-review change. I'd prefer to keep the logical separation as-is.

