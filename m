Return-Path: <linux-hyperv+bounces-11615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eg1bKjJLLGrPOwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11615-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 20:08:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B7D67B8A0
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 20:08:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=Q0Au6mQr;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11615-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11615-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7696A3310801
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jun 2026 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B6375AAB;
	Fri, 12 Jun 2026 18:04:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020088.outbound.protection.outlook.com [40.93.198.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94011CA9;
	Fri, 12 Jun 2026 18:04:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287466; cv=fail; b=fb5vW0Vy4N1wsZIt1V21Nd7xCDcBhL0Od2c0nTd4KgGPlxdFBnEHKoNpxbKV5OcTGXDr/U8FO/8sdt+WQcMNrfSbfWYNuD2OK4TbdnxaRxQdOpldAoiFtFZHp487JbkvoB8f96+BEHeC3hys5UJtKzbfg9NImMBuUnrWH0XAjsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287466; c=relaxed/simple;
	bh=Yj3n+dS6cyeortWRdL2zTTdSyb8HJIgKiY6WgKiS8Ok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hROjB2rtmvopp/Qe0HBhph40FDxBDlDVm2IS5/kOSnQr8MahGv6sQBPeq1hUsJLbo8yOAYrhdv0m9JqoG0zJpkbrqn0xK+gQN69g38/EzUtBnkAVy7kjih298WJ8JHYn3GVvL2kAq3IMe2r5yE43HEfTA3A0jkUBs/aTWvmNZ3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Q0Au6mQr; arc=fail smtp.client-ip=40.93.198.88
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcTSRUx2dowEXJFmHAm6kr7ki2zqWCk6CLsUOsSRqMqOG4UL0Txh/uwgZkVZytgHQW+FZPWC7SDSifB5MHvMCjkxt+aOqcsKOe/THzl733FIrLPiRoGSREsrGQV6X62n92kPiofHLSYIIZGiW94HTBuhhnVzDoEs7Gt44XOwW4cwEdo9grF1Jk4vvCRmSF+NDWAtsYW69biu+4m8ccEIx6kTC4C8hu33jTXi8vrwiadAf4A/Tj96QtyK4ZwAYCjQZuOFfVFZ1fHDwVHDj0uvESrdPnebDvtq421G7j7fD++Kce1wGolV2Z5q98K1dLRWtuIrJiGI7dzocbsxIs/aqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TckYa7PCTOLxd8aisG8gm/5rO15sH4j7JiLPgdO8rA4=;
 b=XTRIouIUuAi1ZcSOSI9H2QyVdY6o3w+RoffpruUY7KNpcO0cSYvg5ymTYXKz9FzCysSLPx6SGomlVdJCC6+u4wyBh9e7Mz4A1bzpW2Ik8FBfqFY6P/anhedETe0hB+o7x3IJZUKKgOtFIWPxZ1PcUdjHhvHg5gozpZGCHA8jFbffC5x6kEBtFxKPEjCpTVPUq83EkgHV0oLfpk3hhumGFhYTYCNpjZi1rOhSRPw8NIn65WrhGVpHgv1TSoRPBQ0QsUQ0h87j3DnwvLgxZKGQH9L3O1LHwOdgxl/GU9FBjtFDMyUtd5br7+W1vGoUbYQJX1zqs2C9/hQArJey+D5W6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TckYa7PCTOLxd8aisG8gm/5rO15sH4j7JiLPgdO8rA4=;
 b=Q0Au6mQrcqxyKId8ERzG23MhMtEcxQgFNvYqT3hOEJuTGiyMfvXzNiLVcHwmlZW3ZBBTLtLzxhx6bp+4cb8IchupqvKWQOqcfiMHNoLrn7pueHtHupwzQGwRrIXRODOwsKcI3DW2Tjfb5E057ToGBxOlcUjIOHJ8qNhQXW/eyF4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6034.namprd21.prod.outlook.com (2603:10b6:806:4af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.6; Fri, 12 Jun
 2026 18:04:22 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 18:04:22 +0000
From: Long Li <longli@microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Thread-Topic: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Thread-Index: AQHc+pKWKwCco4Www0Sez45fGXnTmbY7NNFA
Date: Fri, 12 Jun 2026 18:04:22 +0000
Message-ID:
 <SA1PR21MB6683BAA40F52C52150D7811ECE182@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=495da86f-76e1-492e-89db-92b4c7f99e36;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-12T17:57:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6034:EE_
x-ms-office365-filtering-correlation-id: a7a52910-ed44-41ad-d453-08dec8ad080b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 oQNl3DMkdK3MMT0CZMlH0hVpLx3j3MNq6BtN+cRtLW5yq2yqth07mF8YWY8fX47LvRxHxHyYoKyV1O9kGpY1nSE48zvhUqxBeAk4CoQCsxYR626AF3/BAvozisI1CMlas/uYKQK0UFCPKyhhEZ2BXpCxuLZq1ljDfC5Bj0Ubm6ZlZBDYvoTN19w8OyGXoiChSnHGViVEC/zOyE/io4ooGBsfRY4p0WRLVa5Fk4M6Px9BW38AxZvvhpwCAQNO+Ls58n89qd2UQ5Ja+o6HmxVUBC8fFwvSU6P4q0sjvk3YArNe+eonj5pz4BwiocMhYsCBbSacPQH4mVKoxnadfpnyK+TAI/flCpJqv1QzxppfiIooGdLdwaYnaE9d+ZxilFYJA/BKjX+xnaL24tn0u6M+NF9ts7iBSHKLza54JhrzJ6OnS/D3A2n6K4OMeX10oaqaDwWP6Ubl/GqPx2BXaBoVJo95UiGS3ZQ/wYfFqqehVhZxieWPZeLel3gu0vwBQq8zwPUDhJ2LeZHchKoo4WEQlPToMVu/itJHtrSBNhbVd9aI7bUjfDKVdInZY6D4AzDdiJkCXbtp12BmwHpNfhksbwSHk7SHo6el+DmLltseNv/Dnoi6lGVzsCrP06sAKv3TUcKGVF2PrSKKMKNncXF4mhEqnMEx8zcb1p8yWhuehh1Qps7HtNhZofmwIx0+gk4Nx7cTb4rWcdl59HQLZOtfcCk48K79bFvkSseKapCwNGxcftKbI+2+r+wUqOGwYUXn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?BH0Xqo38ubvDUDxfPUvYYziIci/qmcJJsOCCitvKe1Add3eWjWdo3YnVbQ?=
 =?iso-8859-2?Q?J27FVD8ctWGsyw98XTMtmGSwIw0g9cZSEF7xr6iYHEhw+HcOLWKPDDGmqp?=
 =?iso-8859-2?Q?yA7hIWBooVhKDzKxoHonH2UVlOlmfOJABeqKqIEukdz6V93kAw5STJ/Tlx?=
 =?iso-8859-2?Q?HnsilVFiC9bxK+SkKR+HvSAZHYo8jQ03Zyd53Jnj6K0H6JMvmmVbHGro0D?=
 =?iso-8859-2?Q?kUtJkaRZWit0hJ4sm575O/ZfIRqGtSDC1tTtNwwNAvva42LuVEoXSAKsFt?=
 =?iso-8859-2?Q?gwY92nk5v0yArx2lycMDLaq+9GuTf4zkQpMD3YYvI6R4/g+y8pBJwZd5Xk?=
 =?iso-8859-2?Q?QYn1NPRrIgz4NzhGk7ZiFH7Yi+RxjNBJAIiNob1Y0Z3EH++9UYYKOqer+P?=
 =?iso-8859-2?Q?iT4/DHXTmb1WfIDs8uFDIgOPmxdIQdUTPQf+iTJDq/1pkt8l+bRx6s9qRy?=
 =?iso-8859-2?Q?Uj1lX2bA9Qbt4sqRM+Er38sOambDERBV6xuHuh8gSeYczjnCgK37AdfmD9?=
 =?iso-8859-2?Q?NwQGMghTvFYYPPzKDPCTWO1Yqa22L5wT5xGenY29lBRvL/n1mtjWPrlxBc?=
 =?iso-8859-2?Q?lK++YpWWDq84Jyy14G/FsH3X0fFTO7LM8iRaplKHi3xKQUyRb2dtsBj9AN?=
 =?iso-8859-2?Q?bz0ur0aTzHPL65tCzCujWgyJMQAky/dJm3PkkGWdeaX879A/wS+KLg0XRh?=
 =?iso-8859-2?Q?FVwmMX10P0euEOMdwwaz0D3g9jsMG0VRUFc+jTIt1dwpcl2zTClsgkz7T6?=
 =?iso-8859-2?Q?EpkXDyminsuHTn5auC3jAVYXFYWhOGLJ3YrCweKowCdDfyyelMijFKDDwQ?=
 =?iso-8859-2?Q?A8oCx2sN7yOKn4X4EFY1tFN313dHmvzxQtoqfsIQFPzXwc+j9/pWRr2ywN?=
 =?iso-8859-2?Q?2npBgYJN/awMmoGlQ5XKtbUYnyIpBvoMXX5OJkToU30Wh9Y9KAviMYrxl7?=
 =?iso-8859-2?Q?qUWyKI1+sO4EQ8l3gBZGa91Jlfs2IKeduM4iI19vADFKbJK5r21SdU7KQq?=
 =?iso-8859-2?Q?zQFLgt8+0u1KAcKZLbu7YfXxqmS4FBmhCAky9wdptIOEZCcuDFi2ugTl05?=
 =?iso-8859-2?Q?C/9ipIdHx7bblO/i10BbRVAw9stOw9v03VW7RC0RvheQBace24VhyhMn9f?=
 =?iso-8859-2?Q?1qJ7fqyFj11y3Bc+qemarOvWZsQQA4VTPskmLkGJR7Pkj+4K2d48M4tau0?=
 =?iso-8859-2?Q?AZqkAPeoqrqKyg0gdeflFFCe/bS5JEoDJ6xXMZUEbTPuO3vNGz6nFFgh28?=
 =?iso-8859-2?Q?3qELXbwbWmGUdHQy4yDqpS6+hJPMoFxDlsu/WdFZOPQfI94UuCHTvc0R4+?=
 =?iso-8859-2?Q?Y81FDx/OcZO9AlUXD4bWFljkzGOpaCe2CZ/6Wg3BIZpBOZzmBWgpFwCpCF?=
 =?iso-8859-2?Q?SCpLfT36TMscv+SeNlfXuSQ18sDNyRaYNFf1DUvUcz9a3mIdBRCvWQD7ZN?=
 =?iso-8859-2?Q?mQUImGxBdAnUHjgnlHKN8kTMKEu7z/eUa7r40BWLo7HAjlmNPWRkKBVV5P?=
 =?iso-8859-2?Q?P1KJf0J2zytGyc/VUeUxpt6VptIVfume+yYRzVfPeCMHjz9noOCI2oHA5P?=
 =?iso-8859-2?Q?vhoMHRbuajA83l29Dxy9M0p2mJ13ThEUQJALo21gR9y/UmoPuC+N3iC45G?=
 =?iso-8859-2?Q?Z8MDo8U8fQKhkyyJuDxgNQmwL2TuvawqecdaXvWGgIgIJYV7KpLXRcLAwa?=
 =?iso-8859-2?Q?Jni3ae/21Kidlew9cEK52XjFgNAZtPTN32s0Bs1GnvVUmIgxg8ZREUK1HE?=
 =?iso-8859-2?Q?HJPfiadAW8JZbT1Qzl/iAvg5hdFF6SvgIX2PG/3T99yunV?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a52910-ed44-41ad-d453-08dec8ad080b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 18:04:22.2722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYo0GD4cCO8tmVedBo9P7aowVMmQqDR6L90wsyNwLQcPLt/dhKqucR4PV1u38qjGhC9ROYvTXpP9Qtng6+OEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6034
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11615-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hamzamahfooz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09B7D67B8A0

> Subject: [PATCH] PCI: hv: add hard timeout to wait_for_response()
>=20
> It is possible that we never receive a rescind event, in which case we wi=
ll wait
> indefinitely for a device that will never show up. So, assume a device is=
 gone if
> have been polling for more than 5 seconds.

Can you explain in what situation we never receive a rescind event? If this=
 for dealing a device unload when the vmbus is dead? Please provide more co=
ntext. A kernel trace is helpful.

Does this patch handle the case where the rescind event comes in right afte=
r the timeout?

>=20
> Cc: stable@vger.kernel.org
> Fixes: c3635da2a336 ("PCI: hv: Do not wait forever on a device that has
> disappeared")
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index cfc8fa403dad..bd63efc4a210 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -52,6 +52,7 @@
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
>  #include <linux/of_irq.h>
> +#include <linux/jiffies.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> @@ -1038,6 +1039,8 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>  		kfree(hpdev);
>  }
>=20
> +#define TIMEOUT_MS 5000
> +
>  /*
>   * There is no good way to get notified from vmbus_onoffer_rescind(),
>   * so let's use polling here, since this is not a hot path.
> @@ -1045,8 +1048,13 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
> static int wait_for_response(struct hv_device *hdev,
>  			     struct completion *comp)
>  {
> +	unsigned long timeout =3D get_jiffies_64() +
> msecs_to_jiffies(TIMEOUT_MS);
> +	unsigned long now;
> +
>  	while (true) {
> -		if (hdev->channel->rescind) {
> +		now =3D get_jiffies_64();
> +		if (hdev->channel->rescind ||
> +		    time_after(now, timeout)) {

What if the VMBUS response comes in right after this check? The completion =
is allocated on the caller stack, and it will cause kernel OOP.

How do you test this patch?


