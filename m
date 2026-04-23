Return-Path: <linux-hyperv+bounces-10357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHnuHeyC6mn80AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10357-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 22:37:00 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A04574D9
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 22:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBC863009570
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5833439F;
	Thu, 23 Apr 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Sw/6dadu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011072.outbound.protection.outlook.com [52.103.23.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBA334C39;
	Thu, 23 Apr 2026 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976106; cv=fail; b=A54MjTsS6v4L9HSOP/Omnd6HQdmbj2p9QL0kzBfO0+jp3FrrXkadISpaTQJT4yTQ+FOLKi5t8ZtsKomkbzGxE8hqBmpjwfI8bkkOL/7GnlQ0nZW6fLvZiy/WD6OKnDif1qVbag5YBvCGCCfglxvoiF4HrifTA/SCY3UUROlHi1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976106; c=relaxed/simple;
	bh=MJsMh7Av9Y8QfzivpVSh6NcQ5o03brlNOJiYulsjSW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OaKgZ8vS9gr+f1cihmLqm/xkGOEg61WqLKLUR3qPppUttVnxV0sUSpcaBAqBNS7AJr8YcZgx8II7KOw7sf1hbyGFQGcI2vzfebM2q4JZ7hbOBlg07VDwyLYL/6vhWmRan2/7JbiJ0G83AMJwc2GsjVu+mcPVdhgmsWWEfkEIgWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Sw/6dadu; arc=fail smtp.client-ip=52.103.23.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbYexjMn96dwO0YI1zcXzWRJP+a8vOXxPt5468/r95GCMaiCKR01sb1Yy+OH4Kr+5J9Q2VVHXEa1yFhqKU1WSKFEQrdddSKy/LA94G5HTIYtFjwyhY3LIR7b6T/dthfLkdwF7ub+bAfoKIdi661+MOOX8hcRS3FCOftSFTLm6odHXvB1u1L5RthWyDJ5ZV7kpHw8RJJVwaMOZtHXXnKk+ntFAnF85vyA5PFt4RD86+LMRfb81VzraicZ5OMPN/fmb5qGC3HsOSEuUyk4jMi4aRfqaFglsCYTRW+x9SXIXuYVDNb/1AFoRBa/HFsmo9kHHDoXv39MW6i5Kx7gpnUn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVxQYgFN0npcosU9XMKz3VpuU9T3RJUd+diQfDxLrn4=;
 b=GkmEqL1EvcVvkiqzoK50/3QBn9RbyZ3zgCh+w3xJ29NYVMvGfA7yVe/vIAafgYWFxNYh9tXzFgGefRmY74QG6ebytxaBlcupwj+2lkZExvKCm0aEDlWBI9Ru44EPSb0ni6G5WsdQF4gdgOxCsipruZuYS02o9od6Kd6yq3bkSJxkOzyx2xCjGcSCzeGrxLH/DWleyGlO6CtwkFUASpXwIaqwME0kuz1MobLjztiuvjqMj1Cu8/HlSjtkXC6fElvG8lZWj744773Gf29J2DYQB6QjAPtNAlr/R22oEMCUpDoL0QkMTPHvYoF1O+l6tcTqOf0oRX3QpxUy2qFupZdUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVxQYgFN0npcosU9XMKz3VpuU9T3RJUd+diQfDxLrn4=;
 b=Sw/6dadukjaIQxcg+0AuU+Bmb3Is8yMQd9ND9eZGSgFchxOi9fZNGqNWDZQNU6j+jG0QuWomOqPI1My1TCVoJgdhIE0cq9wcnItxpncfvyBOKAYXBIHHASI9/G14KhbqIYRWyoquM9eFkwqqbtDW9HjocEOlEPYgdcIicWbmJhFrMCzveyzR6VWPOSQ91YI97/zxo9p0WzTse6rDBb89STSTtsnMcw7UiIrm9rthJwfg1pRK++OiuNmP3c8GpCw3uokojRefD2Ta+F6tOUMiI4Rs1W3mcAHS9Orxm+ZSGa6L3ec6gH7m06vpEOIauvX5wZr2B0EOPry1HXQfOiD0yQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9200.namprd02.prod.outlook.com (2603:10b6:8:11f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 20:28:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 20:28:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: unknownbbqrx <dev@unknownbbqr.xyz>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools/hv: fix parse_ip_val_buffer out-of-bounds write
Thread-Topic: [PATCH] tools/hv: fix parse_ip_val_buffer out-of-bounds write
Thread-Index: AQIVQn7+COMSQvlZQe2jJ6juwEvJ27V8OJVw
Date: Thu, 23 Apr 2026 20:28:18 +0000
Message-ID:
 <SN6PR02MB4157E03D054CDBAD1290E05FD42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <c9871f25-9d7e-423d-954b-4080d2484cd8@smtp-relay.sendinblue.com>
In-Reply-To: <c9871f25-9d7e-423d-954b-4080d2484cd8@smtp-relay.sendinblue.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9200:EE_
x-ms-office365-filtering-correlation-id: dafe1e7b-ee1c-46f3-bb8c-08dea176db66
x-microsoft-antispam:
 BCL:0;ARA:14566002|19101099003|55001999006|41001999006|51005399006|37011999003|19110799012|8062599012|8060799015|13091999003|12121999013|461199028|31061999003|15080799012|40105399003|440099028|3412199025|102099032|19111999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZTY8DcNr68OBATBptX8Q1TnFuusk5XKBc8bxoSg8dcOsgbgVatWd/c8YEUnZ?=
 =?us-ascii?Q?yQ2rjqKQThfY5N0vTf0LXSzxIwhUerGSe7YcTv09pHQCTrf9HnH7JDeu8MsA?=
 =?us-ascii?Q?Gu6avcmZ79TKg8arNU2CFJCSzXdY009O5M2yuUzP0tZlIytRxF0BA9cvFPDb?=
 =?us-ascii?Q?V6UHeZfPm8Txgcc5ejtf2s37VPubo4E1lhyv6WSHHIyQCY63F2I4p/0CGnkN?=
 =?us-ascii?Q?PTW+K2Chms+bLuCWSIrf2hlPjlsXJ+GKwXFgSrhrSKRTRQJZoZ95qxVuz18N?=
 =?us-ascii?Q?yRlAlOaHq4IZzDxlDQV03fWuxGhI6dLYZseB6zvqmQEYcLrufcIDk6wEBpdK?=
 =?us-ascii?Q?KbAgD8BUoq1Sf5R9IXbbemn2wS4iyA5NYgdmuQ8424RT6zzgr56S9m7qtAuf?=
 =?us-ascii?Q?pZaFjGH6R5fFJ7v3Jwav1gqcKEpl0TV3/dXCVoLj85O0D6c68lSOYI1TkfAn?=
 =?us-ascii?Q?9syRiLbzPNNNYJuQrabUhSfvAOq6UShcAzYxuNcDksPgsdtak9bLRQicDsu3?=
 =?us-ascii?Q?PPFXaJ01idBbvm6pob1i2H6zKrOrh6imcnARcok73dCqwzTV070UGDTaPDyT?=
 =?us-ascii?Q?L5UZgfTo20FJRLD4N91pgHD9U1sGKwm5VMKj0ENWy5m1Rw/aH61RrThrveKp?=
 =?us-ascii?Q?3WUrYwZxKY97oLvllSPACQxSNEXDOGnp/FZrT8Th8LfWy53e13Vj7YinEMU5?=
 =?us-ascii?Q?2HCqxDeALWZqccDMedakHAXg0cPeo8Ze1ILGrooPMR8j5FqzK3pmSzxrsY/e?=
 =?us-ascii?Q?qmmVVV/tY9svJa0JE3cRvwWy3xhe2swKrUoPSal3KY9sciR7slDRGSq71ZfH?=
 =?us-ascii?Q?qX//4z2lLdajdRSYlID+zcJR8KExhbMqPQAYZv04573kGE6pqhjDWmGO0mMQ?=
 =?us-ascii?Q?HZLLsLyz4Wmk302iHY8lOLDCInn50jFpOGJaA4x/C8H8zbpZRxUmXOIeXz8m?=
 =?us-ascii?Q?WNdQR4SwJ6VV7RboKoFDGdsNTVz6DasZLqHlVg7jIcHi1x06nLdg54GDJlLF?=
 =?us-ascii?Q?WBrT2aFsM308/Q0lL0Ilzl492WjJkIOfpCJY2fyeBmhqe8eyk4/TF/A/lckg?=
 =?us-ascii?Q?m5yU0430iT1i7kI7S3TPEFgJQS3omY3g7azudFD5/02KQvJKs+ODiU4k6RBD?=
 =?us-ascii?Q?GP0CkcsJ2eHI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x6/hiav6EZf8m3ZuMyRtPZchbLmjFtB4GLsojpBAhI0vS/cc765J8BBBLDdJ?=
 =?us-ascii?Q?PTzI9mJVcPoZuCNWds7anBzTu9/4BjbgclDKS7EA83ZAqzY0jiWo5hxYc7q9?=
 =?us-ascii?Q?K8vP8R0g6F11/LHfY5zK0Nwih8+tn3JplATCLBlmiMexYPWJuVrfuDAi7Fpe?=
 =?us-ascii?Q?N2eN3BYjsZ3pRoUfvBfxebRVs6EL+ceDTDXB/Do+Owgii3YNyUkb9ImomGt7?=
 =?us-ascii?Q?bJFq/vHhaeCC4n5HlEGr9aqm8O3mLQONxBsOk+JDi2GjvHucaRrL84K4dCXD?=
 =?us-ascii?Q?NVGU2AndQNGwaEh466rukquQM0E+k4AAbWTORRu27a5E2L2+ov2V+qRL/orS?=
 =?us-ascii?Q?404BtGwXUKueABPpc5DtELTw6BO9lSJddLjgmW6dszIA2c/0svYDH6215/zi?=
 =?us-ascii?Q?1yK9VLTxqdSHnvhbqU+Idlfid73FcuFoTwdLwqGOWEXwTa7Amnvg6sEo6/CA?=
 =?us-ascii?Q?dnakNjAWjKv4HdO7wR2k/7jALp/j+NL5Z7SOYEH3fBUMV9AhJ3g7OfMd5k+C?=
 =?us-ascii?Q?glu4LiEOW7gpa8LildYypjNhXx91T6Nqt+ARiwPdvt0hQgnC0YEmy4tsVnBj?=
 =?us-ascii?Q?6B1FE53lUTDXk7vij/3q6TbR5TpFo7sfrWP50hk1pljdti13BmPZzQud7fTO?=
 =?us-ascii?Q?T2zmRIhohVw98Kx8/iMhJ0mEsu53No4aJ0afNJ6WeqSObj6Zm7Xb6IO7xSXu?=
 =?us-ascii?Q?WG3aPWKUWak+Y9//wSv3uWLrw9MY1YeFUrAdcimDPjySJMYotEIHv1MktjkK?=
 =?us-ascii?Q?X9v/gFTY4hjSG4cNpNldg/WykJksibVXn7M+PylklgrHmf5g2A3+mB5JrxtL?=
 =?us-ascii?Q?5dUmvIt00vL99cV/Zn6x+7k2H9oMOMG92Q/Cf4AiyiR5Y25sPIPgKxvyAqTD?=
 =?us-ascii?Q?jMDPuUowBZT+R1toFACKhv4NeNCvdbnZZx60J4BsbE8EBpwIGcaLAsyWjTry?=
 =?us-ascii?Q?F7yx6xldKzrQMuf8GxieYqcKcpiaxgcJwFwYPqY3sOYsuC5RFZHNf7YOQ4Sp?=
 =?us-ascii?Q?K3tWPhrYs3s0CtqFPZrXooONyN1uK1UZQ071jvMGnArP9mM/s0n2d4IrJ9ld?=
 =?us-ascii?Q?pAnew4GiO+Zg7/1TlWvOlnKLRMVjhpeKXJny0nU/loFiagcLKtPBXF+XB+yf?=
 =?us-ascii?Q?MkCyUevYIbqO9IJ/KxDg6NiKZRyT8vqzL5Ue4RGX1MxqEqdOJsxF4E9E6t1D?=
 =?us-ascii?Q?yeg+tn0MQpCYr3sKhmWeLo9Tg4soQSgvjK7SAWQdDsvPOgcJyCQicV6tXJFy?=
 =?us-ascii?Q?R5M8fMlG7iOCo8MfGkVxpebWksoSuIHKGvH25PsybWH+TUAYVFhx4+nOPdbi?=
 =?us-ascii?Q?by6Qjyelpe4Tr8nXDIDy3EKCj7mguHNix8DzOZYPQhvYznQePCUVC1Tglq49?=
 =?us-ascii?Q?AWWBkKo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dafe1e7b-ee1c-46f3-bb8c-08dea176db66
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 20:28:19.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9200
X-Spamd-Result: default: False [8.34 / 15.00];
	URIBL_BLACK(7.50)[unknownbbqr.xyz:email];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	TAGGED_FROM(0.00)[bounces-10357-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unknownbbqr.xyz:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 781A04574D9
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: unknownbbqrx <dev@unknownbbqr.xyz> Sent: Thursday, April 23, 2026 11:=
07 AM
>=20
>=20
> parse_ip_val_buffer() validates the parsed token length against out_len,
> but several callers passed MAX_IP_ADDR_SIZE * 2 while the destination
> buffers are much smaller stack arrays (e.g. INET6_ADDRSTRLEN).
>=20
> This can lead to out-of-bounds writes via strcpy() when a long token is
> parsed from host-provided IP/subnet strings.
>=20
> Use size_t for out_len, switch to bounded copy with memcpy() + explicit
> NUL termination, and pass the actual destination buffer sizes at all
> call sites.
>=20
> Signed-off-by: unknownbbqrx <dev@unknownbbqr.xyz>

Linux kernel patches must be signed off by a real person's name,
not an unknown alias. In the kernel source code tree, see
Documentation/process/submitting-patches.rst and specifically
the section entitled "Sign your work - the Developer's Certificate
of Origin".  It specifies that the signoff must be done by "a
known identity (sorry, no anonymous contributions)".

Michael

> ---
>  tools/hv/hv_kvp_daemon.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index c02f8a341..ecf123bce 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -1188,10 +1188,11 @@ static int is_ipv4(char *addr)
>  }
>=20
>  static int parse_ip_val_buffer(char *in_buf, int *offset,
> -				char *out_buf, int out_len)
> +				char *out_buf, size_t out_len)
>  {
>  	char *x;
>  	char *start;
> +	size_t copy_len;
>=20
>  	/*
>  	 * in_buf has sequence of characters that are separated by
> @@ -1214,8 +1215,10 @@ static int parse_ip_val_buffer(char *in_buf, int *=
offset,
>  		while (start[i] =3D=3D ' ')
>  			i++;
>=20
> -		if ((x - start) <=3D out_len) {
> -			strcpy(out_buf, (start + i));
> +		copy_len =3D x - (start + i);
> +		if (copy_len < out_len) {
> +			memcpy(out_buf, start + i, copy_len);
> +			out_buf[copy_len] =3D '\0';
>  			*offset +=3D (x - start) + 1;
>  			return 1;
>  		}
> @@ -1249,7 +1252,7 @@ static int process_ip_string(FILE *f, char *ip_stri=
ng, int type)
>  	memset(addr, 0, sizeof(addr));
>=20
>  	while (parse_ip_val_buffer(ip_string, &offset, addr,
> -					(MAX_IP_ADDR_SIZE * 2))) {
> +					sizeof(addr))) {
>=20
>  		sub_str[0] =3D 0;
>  		if (is_ipv4(addr)) {
> @@ -1374,7 +1377,7 @@ static int process_dns_gateway_nm(FILE *f, char *ip=
_string,
> int type,
>  		memset(addr, 0, sizeof(addr));
>=20
>  		if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
> -					 (MAX_IP_ADDR_SIZE * 2)))
> +					 sizeof(addr)))
>  			break;
>=20
>  		ip_ver =3D ip_version_check(addr);
> @@ -1426,12 +1429,11 @@ static int process_ip_string_nm(FILE *f, char *ip=
_string,
> char *subnet,
>  	memset(subnet_addr, 0, sizeof(subnet_addr));
>=20
>  	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> -				   (MAX_IP_ADDR_SIZE * 2)) &&
> +				   sizeof(addr)) &&
>  				   parse_ip_val_buffer(subnet,
> -						       &subnet_offset,
> -						       subnet_addr,
> -						       (MAX_IP_ADDR_SIZE *
> -							2))) {
> +					       &subnet_offset,
> +					       subnet_addr,
> +					       sizeof(subnet_addr))) {
>  		ip_ver =3D ip_version_check(addr);
>  		if (ip_ver < 0)
>  			continue;
>=20
> base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
> prerequisite-patch-id: b61dd51dee390277603975bf729a687113185c3a
> prerequisite-patch-id: df28525061dd528875c7c75880b4684d80f4aa7d
> prerequisite-patch-id: 64c48c6f2222781631304d9d4d7d1c712c002610
> prerequisite-patch-id: 9be258692732026bf560ed9887adbd02a8887263
> --
> 2.53.0
>=20
>=20
>=20


