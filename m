Return-Path: <linux-hyperv+bounces-11075-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDWVAmQxDmrj7wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11075-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 00:10:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D30259BCB1
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 00:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 569AD327E533
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181F280CD2;
	Wed, 20 May 2026 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SKelTBRQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010021.outbound.protection.outlook.com [52.103.7.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C126FA60
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303715; cv=fail; b=Mwf8i7c03RCpk59595dpxmGbEWXVVR/RWzm6I1LbTT6A6wQAA3Sj6TV92otP6mm50UzANPLK5oqcC+R6O6JGIXnCZFeBCWukK6KabOM+YJUEBazPgHB1s4tnXQg6D51saFHyMZqohG6RkZiXtJ0bKBpYKQFpwaUPLt42mePO7pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303715; c=relaxed/simple;
	bh=vO5TO02kSvKgW7XRNGiUJqgJyqr2vT9Uc+6xmGAkULc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9NONVyQX7jp7SU8W630ISmwYQinOTMh7PkQE/wcaapHhz479knzZKBanRtoExggTeuzvE/Q7zANv6PpHzfdrBpboiwCAj/rRS6FfaO+gKD9PM2vIL1WAlgmqLjcQy0oH0H+Ai7afhd68SM+AiewJVtbQNMhVF3lR0qloXVVItk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SKelTBRQ; arc=fail smtp.client-ip=52.103.7.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8gDB7zH9LKrZ6bp164ynzIR/Dy1BFONXTD2t8JSiSelhfc4ynsIrVOJ3h+2QvH3D5FbFYDu77vROPfIZ0LUk7O3+CYaLdwrP1HEGZWntfHfe8eQ91T+qZQwVT/o77oJiw2qKuKOOGtxqLFK2jDs4FRKsXY2H5wBVkBaMqusLaEJImxBpurNONfB1fcFxXEyul7nF4fa0wmMUbsZRlR+knb584KQvXHs+CwRR7z9cL1xuyDWbtjMlNGSkJ/xhSd4IEzdBGlLVTdcguoG0Dxal3Yph3qRfvAg6xrxhkCI2ta6IL+ToIew6iIHOrdVmKKHXyywK1bgdU7stVk2LjmTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXS+Cz92sRyQ8jpIB5cCztgedqG20wOeAppdTezy6Ms=;
 b=e7xKDzkMNuuv2do1t75+QtHit1wTW3y0y3CdUek16oZefMGh0PwGbzi9U2af0ciGP3yEZmfefcIsNTJtb+f2mbqnvFccMCGMyqAnl6jbDs6SpuJtfffCkHvbdZmlK4hvGsToHAVm0+9BAge14E4jNyAp6wMQjZ3DwVEJYMzh2wms4zQXIYgXQQIer16bzkJT5ubS39bN5/vKJ4WfOzmW9KpnPmgKI/4D2h9ieoDUqFEAy3b2O/MegoAKwI7TYlyKNW+qF5j2h3CQw1gA9yREnbKe6U4d+eYMBR0PrfKZuiG7IVb1GDG6rqvf0YE3APw4RrOi65qajQMsLzkf2NIBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXS+Cz92sRyQ8jpIB5cCztgedqG20wOeAppdTezy6Ms=;
 b=SKelTBRQN32eX1X34BHv2E9pdrKSQG66tpyHlhQFnfH2iY9+eRvDXAzGTb7pxnTVVcT/j5k0L8rxR5dPAZc1G6jbs6Bh87oWG3x8gpkj0NCB4c5WpIJSydjX+NiZ641sHeHgTIpq7rFAoKgmSXTdM+iRdX4uAYAJhx7A8zSaUOrZ1CT9K1kRi5Qi7kExpxqTpS2kl4YQyCZRWlYRntaSjQ5/Iq9niJHDPeKw3FebAMLzpMWouobVk0J4LKVaph5YTQhT3HlPAZsPyPxcgOQs65xOuCsQpGpVcR8ChLm6Zlpj6Nfel7ekMZyN7aDi6ZZzjmjjPV93Kq8ztpcEhZvcBA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6927.namprd02.prod.outlook.com (2603:10b6:208:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 19:01:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 19:01:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sean Christopherson <seanjc@google.com>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 31/41] x86/tsc: Pass KNOWN_FREQ and RELIABLE as params
 to registration
Thread-Topic: [PATCH v3 31/41] x86/tsc: Pass KNOWN_FREQ and RELIABLE as params
 to registration
Thread-Index: AQHc5J/+S6zzZLK3PkGQwXsR4aATVbYUXy+BgABF6OCAAoCBgIAAJeQQ
Date: Wed, 20 May 2026 19:01:48 +0000
Message-ID:
 <SN6PR02MB4157E07574E2F045A8A1DF59D4012@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260515191942.1892718-32-seanjc@google.com>
 <20260515194535.56B84C2BCB0@smtp.kernel.org> <aguQIJQYsarMScnl@google.com>
 <SN6PR02MB4157D50A944A2794475E32FED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ag3kFYLrypsBnlkY@google.com>
In-Reply-To: <ag3kFYLrypsBnlkY@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6927:EE_
x-ms-office365-filtering-correlation-id: a4db66da-1cb8-4956-9dee-08deb6a23eb0
x-ms-exchange-slblob-mailprops:
 AlkLxVwsndmv0iZj3buVhxZxpTBtM8DuHpYWM/vyKpcifZtG5GDhcvr5mUt8fVmZuk+0s0koeOIkauPlgTBOmt6sTBciT4WrqV0JUCuxTr5ARNq+FLaWF81s5RPgT8OnZIar0Nx4cZ5uR9+wrVBgdGlUJFRC88Oyt4K1maome47IhSA+/Uji+UrxDKN39/lo/Vqt8ycR0tK6kacNQlRFUzedjEv3NfvG+nDiXPx8+QBZDPajSCFjYHkX+jooM2jktL/hXH7/hy18dUitg0j031CNtfzMTWzF0GsOES/QqE8q8Rt5p4nxeCHZHNkxJ7m0Eu69h4edGoDfQKaJHouUnxwqhSD63CWzFhRqpfb65FYWyj4EKwE3LBAwa+wM04bK9kbLk/6SqpZUGEWwTBJG0VVyiEEnbHRBOU2QB/rJxE4EsDWIyIWQv9yUq6JKFD5J8FXssRr0lwi+HfrVYKFR7jNZbWZPEbuxIt77Pdxs3SoKwsy/TAJWVC/OrnsDbIRMAAc1U4/DmLq1QmkmYAh0xAzrywCLg/Gp23O6Ul2upUbRQbltSD1t79eFs7gR6kgQ8rCUfK4LFW1m0mxu7ww9WxAn7seo8/+RDWgzhsJkBBZXpME2Mjyzq5eteNefDJVQc2Tf72+ZvXeSy6gx9lQdveZqVwjZvDPesmatdmKDX95kz2fXcja84k83mZ1Tg1WHx+tyet9Cq1i6HuU246uVbIkcduypzwnhy8Y/SEojgDLvyenDymtq2VtmsS896G1x8r8qEzj/z6WoLYyvkb13RspZw2uW7x+o
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|13091999003|15080799012|37011999003|8060799015|51005399006|8062599012|19101099003|19110799012|3412199025|440099028|102099032|19061999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PTcnSfMlv6rPPYSpUS1U426AOol2Cm9hkMe1SM73H2F6ZDOocvIRpzwCDwxF?=
 =?us-ascii?Q?4OZyF3XgYH/hd0edwl+m92wj7KSNpnDte6c0SSfDKiZI7fB3IhJPNq265LX8?=
 =?us-ascii?Q?qhjhAI7v+xcHVinxIV9INKiE3ltspaUvOnlPXi7Ly8PbCy2VjxyzMO1YI8qh?=
 =?us-ascii?Q?NZ6S9TFR1I2eWM4nP1ZZnVkehleEqYQAbFNW2f75q1wkMmwc+LIJ9JlWfo87?=
 =?us-ascii?Q?PJ9u44uLQQlIsT6rz/bhDdGgVFJuz5+B4iRho6EMwCcUE7YmRFQoM6XtwaGo?=
 =?us-ascii?Q?HlxVSGS+bZY3UeDQ3aUR6YF21C/7C+x1TUaTOt4aOa2NjOhERkrV0OiktbaX?=
 =?us-ascii?Q?H0ExSc//HxClWrIDc4t1m95GwZ1deU5qSrl338w79qA8VtQBIqNRkV4+huRw?=
 =?us-ascii?Q?D3TRxbzOkYviVCz3zoGMe6PJBxEGqmOpt1dPJdSRpj11+ztVTWCe6MHDvD+U?=
 =?us-ascii?Q?DHFhkVV+IiPwlV0WqIbVYRa7ZjnwhH+8YJUiN6kq5vNR5KgqovH4y/EtmeBB?=
 =?us-ascii?Q?6QSt40yYZ0EF/TKx2S3X2NaVChz1mNwzSmHHATlsoEHz8e2UN/LQSL0dWmwg?=
 =?us-ascii?Q?ahj6wwEjyatBZAp1xxELFMASHjOrf2MinyAFBd3EmlAkRG5+0n97GbLhx0N1?=
 =?us-ascii?Q?/mfWmVZfSX7byGWd9p0Sy5XixYM4sGZtEL4kpap/7CfV1tLgr0BL6RvorKBF?=
 =?us-ascii?Q?x0UNUfyHWd+ZOa3SnFf7V82NE5Gy4mcefJ5EOuMkV4lvGv/1ftEDSPknuU2N?=
 =?us-ascii?Q?jvLrVos0iAgX0H1NI+TrHawUFyf5SeM4InUJZ43R0D49Yd9owXCSOwB2kmWd?=
 =?us-ascii?Q?/qLmWeGH6PS19oxV321uigpJbG6NyMZFuDQZD2AD+vt+JLJz/1ZjUkl9zNQV?=
 =?us-ascii?Q?yxrPBTTpKLgTLEyxnEic6LQ2CHDjLNmrZTaovrPoFDqOaIjbsM/rCHzS8IqA?=
 =?us-ascii?Q?1QcgHTqnlrWMdqFl9HfM10NElIgIm2LQodGZ7lmjw9+rOcU4QQ/pd7iEELCo?=
 =?us-ascii?Q?tPe9qffzUUHRUoWk82Qhe02kC6nRTUU4Q2fiusoXcD3bX9Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CItn/0nGfcHU6bm4bQYwtOxPhOV8+5diAyIUFhNdJ/Mf0MyZcIxNVgm0DyP3?=
 =?us-ascii?Q?gv3soHHi1MkTo2J+MlHpqrTOZdYHWoeVOnTDYHZhD5KIa8tQPMJhtnyU7e/Y?=
 =?us-ascii?Q?mL1fmIZvdRbFIPr5AMfHugrrUNdDSlFzQ/PxbKi7grc0qKw85CMalYLOeeoK?=
 =?us-ascii?Q?wDlW/oaf7SIryUJ9szNcVkhcoL3l5MiT/cJkVcqNyGbtHCkyCmpoTPF/WtIn?=
 =?us-ascii?Q?a9U91nNFS4tZzDblYRx++o+MdxybQMjTUKH5BnWg5gmjPELb1YLEnHaluSiF?=
 =?us-ascii?Q?JnjayGI0BfL3sSSKptrmxwv23sxYI6iryxeRzRtf7NT4VNSX8dvxgUDQdFRY?=
 =?us-ascii?Q?/2FZrh79xIMW4+m9RqbXkHcEFrGLf5xvdPGhLiEcXmc3DEm2QI55vhvifWl/?=
 =?us-ascii?Q?V+/76gWVYK3XSTPkM+XT71XNCwvSMBcma+9OGXacgGxT5k8rVFCvbJhzbFwt?=
 =?us-ascii?Q?n66UziQ+gd51tCh4x2uuqKwx9D0PUY3TkOgmvFOC+TIzI3xi3R3jzyjrBcd2?=
 =?us-ascii?Q?rUo/uV+NnVXpXehphE5luRXf7ZJQA0yHv3etDGnc5EO+XdE+8GXDrm1QtLVr?=
 =?us-ascii?Q?uX6Z3KQsjW1Cq9A0EPVy4siDXlhlsg36SImfxDDNkSzW/E/qY5ESvhEeXOZY?=
 =?us-ascii?Q?ZUTTnxKjyqcNGnVU+dt4F06qc4i4+L4M7k+TDOklY7mN84zTghR4cvSsGjO/?=
 =?us-ascii?Q?5ticy1NmA/2AQNMePXvgz3rbMqjA3xTodDJtEMXpREh+fMr8QBUJaIG5lPAT?=
 =?us-ascii?Q?h5LxcLrOXRUeZ1U01z3sTfh6R5dkic7nzwDSpaDnsch/uwua71c+fSP63D0q?=
 =?us-ascii?Q?kFcsJVZNee6F7lnLOS0urhmxzGx+bZ6c37bkO0JTVDHypxLqNmKBDgqFrY+h?=
 =?us-ascii?Q?Y9y80lWobpwjSgqexeis1Okb+KzNDGdneZw1ZZeTwAVATQfJLGn7bAP0ei59?=
 =?us-ascii?Q?E1bADMNp4+cqlZytbbB3QBui7NI9db5enCz+nGlwVLL5S+ZGmFjQl43xIuMa?=
 =?us-ascii?Q?e8oupmPZz8RHXSx8X15McM8qKbhpgudf3p1HRMgDXuYImvvIim+S2UBE0F8f?=
 =?us-ascii?Q?++v2vVrI4i4jTpEJy+2P7RHzb+a22y5Eso2E9Cy9WbS2NnLJtSgBVupGj2Qg?=
 =?us-ascii?Q?0FAh+cq8holkm3olyoZUXkMZIk9+GtsDtpkamWgYp+jf8kkZ90lvpKyT73v1?=
 =?us-ascii?Q?sZ3qBBymanjm2FQ+nQvUAxh1az1nek42nLRdOyvSQ86YeVNUMf8X5IP8kOmZ?=
 =?us-ascii?Q?zunbQvmlVb8wMjASkzwJ2fSfCcyKXTn1prtSLVbQrf4fHIKJVsbdHA2qerki?=
 =?us-ascii?Q?0LwM5bB2b2T9z3rQIzq7ncx83f8ojZZeXEcwaA9DnSFbML1QNL/8cfD6Uk8J?=
 =?us-ascii?Q?E0jpeC8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4db66da-1cb8-4956-9dee-08deb6a23eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 19:01:48.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6927
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11075-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 5D30259BCB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, May 20, 2026=
 9:41 AM
>=20
> On Tue, May 19, 2026, Michael Kelley wrote:
> > From: Sean Christopherson <seanjc@google.com> Sent: Monday, May 18, 202=
6 3:18 PM
> > > > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu=
/mshyperv.c
> > > > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > > > @@ -516,8 +516,13 @@ static void __init ms_hyperv_init_platform(v=
oid)
> > > > >
> > > > >  	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
> > > > >  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILAB=
LE) {
> > > > > -		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_k=
hz);
> > > > > -		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > > > > +		enum tsc_properties tsc_properties =3D TSC_FREQUENCY_KNOWN;
> > > > > +
> > > > > +		if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
> > > > > +			tsc_properties =3D TSC_FREQ_KNOWN_AND_RELIABLE;
> > > > > +
> > > > > +		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_k=
hz,
> > > > > +						  tsc_properties);
> > > > >  	}
> > > >
> > > > [ ... ]
> > > >
> > > > > @@ -629,7 +634,6 @@ static void __init ms_hyperv_init_platform(vo=
id)
> > > > >  		 * is called.
> > > > >  		 */
> > > > >  		wrmsrq(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_T=
SC);
> > > > > -		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > > > >  	}
> > > >
> > > > If a Hyper-V VM exposes an invariant TSC but lacks the frequency MS=
Rs,
> > > > does it bypass the tsc_register_calibration_routines() block entire=
ly?
> > >
> > > Yes.
> > >
> > > > Without the standalone setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE=
) call
> > > > here, it looks like these VMs will lose the reliable flag.
> > > >
> > > > Will this inadvertently enable the TSC watchdog, potentially causin=
g a
> > > > performance regression if the system falsely marks the TSC as unsta=
ble due
> > > > to virtualization scheduling delays?
> > >
> > > Hmm, I was going to say that the change was intentional and desriable=
, but looking
> > > at this yet again, I don't think that's true.  Enabling HV_EXPOSE_INV=
ARIANT_TSC
> > > just means the kernel will (probably) set X86_FEATURE_CONSTANT_TSC an=
d
> > > X86_FEATURE_NONSTOP_TSC during early_init_intel(), AFAICT it doesn't =
lead to
> > > X86_FEATURE_TSC_RELIABLE being set.  And I think in this case, markin=
g the TSC
> > > as reliable makes sense; even if the kernel doesn't user Hyper-V's ca=
libration
> > > info, the host is still clearly telling the guest that the TSC is rel=
iable.
> >
> > Yes, I agree. But I'm doubtful that such a combination ever occurs in p=
ractice.
> > I've never seen an occurrence of a Hyper-V (even really old versions) g=
uest
> > where the frequency MSRs are not available or are not accessible. The
> > Hyper-V spec allows for either condition, so we have the code to test t=
he
> > flags. I've thought of the flags as always set, though I suppose one ne=
ver
> > knows what the future holds.
> >
> > >
> > > Michael, does keeping the
> > >
> > > 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > >
> > > but also passing TSC_FREQ_KNOWN_AND_RELIABLE to the calibration routi=
ne make
> > > sense?
> >
> > I don't see that it would break anything. But it seems a bit disjointed=
 in
> > that HV_ACCESS_TSC_INVARIANT is tested in two places in
> > ms_hyperv_init_platform(). Does TSC_RELIABLE *need* to be passed to
> > tsc_register_calibration_routines() if later code in ms_hyperv_init_pla=
tform()
> > does setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE)?
>=20
> Sort of?  It's not strictly necessary, but passing in TSC_RELIABLE allows
> tsc_register_calibration_routines() to ensure it doesn't clobber a more r=
obust
> calibration routine with a "lesser" routine.  I.e. not passing TSC_RELIAB=
LE in
> this case would trigger a false positive (and break Hyper-V).
>=20
> In other words, invoking setup_force_cpu_cap() is a (happy, desirable) si=
de effect,
> not the primary goal.
>=20
> > In other words, I'm suggesting let tsc_register_calibration_routines() =
handle
> > the TSC_FREQ_KNOWN case since that's what the calibration routines are =
all
> > about. Leave the setting of X86_FEATURE_TSC_RELIABLE to the later code =
that
> > tests HV_ACCESS_TSC_INVARIANT, instead of duplicating the
> > setup_force_cpu_cap() operation.
> >
> > While combining FREQUENCY_KNOWN and RELIABLE into
> > tsc_register_calibration_routines() is convenient, the two
> > concepts turn out to be independent when looking strictly at
> > the Hyper-V spec and code written to follow that spec.
> > Combining them into the same function ends up being clumsy
>=20
> Yeah, it's a bit awkward for Hyper-V, but Hyper-V is definitely the odd o=
ne out
> here, in that it has an "out-of-band" feature that marks the TSC as relia=
ble.
> All other PV features that trigger overrides of the calibration routines =
bundle
> the RELIABLE aspect with the feature itself.

Indeed, Hyper-V is definitely the odd one here. Keeping the
"setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE)" in the later code
block where HV_ACCESS_TSC_INVARIANT is tested works well enough.
In the real world, the frequency MSRs are available and accessible,
so the additional "setup_force_cpu_cap()" is duplicative, but doesn't
hurt anything.

Michael

