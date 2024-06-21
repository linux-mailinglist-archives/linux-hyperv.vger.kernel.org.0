Return-Path: <linux-hyperv+bounces-2475-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC52912D62
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E083B1C25C40
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106017B40F;
	Fri, 21 Jun 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a0iHPEoi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2124.outbound.protection.outlook.com [40.107.236.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A517B411;
	Fri, 21 Jun 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995269; cv=fail; b=WSjRUbYewDXQrx10cgnRSymv6VGJUHaz6i22SSmsK/JE2jZ7qBSOaXUtSCgZmL67Ix+aqOKiqC0Zp9m6PPhHgv1X7VY3K9FcYXKNccfzFr4uL4JWwyeqaTRtrMoVZH6vJFoGZ/uTof+QGTu8IXqXr4trf8/AbWU7lnqjBJnB1Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995269; c=relaxed/simple;
	bh=E5+8h7o3q52BzuKPJWZAnVY4+zOsfJdDlvgiZaI6520=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5G/jDuKO9UgsKYnRzJNyK37YcIpZ8QuZcn2kzaLtDqg7sit71C7NLty1C3jhppa+7U7Q9ef5r785/5BQN3oriesgJ2obm1BJV7PlXW8oskMvR+YmYtiZSasFV7WcY1XmTHik/NW8mZ1ujEibZOS6Z+C/DAUKcno1gvFNziW2I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=a0iHPEoi; arc=fail smtp.client-ip=40.107.236.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPmn3RkxwfG+mN9fi7iquZGNzh0n80wW1z+Ct7ZVw+ApKImBRM8cMa4NefiQSq/7TMnNrP3Qnl3Eu9SVRGc3JQHgqgV3OHSBKOK9GCY8OH6zq0ckYe8g71Hk5NeUUfNqhkNO0lLujYIRuk+zF4tTRI5spmjkv7USksPA4VJ9jJ2/hbzLkiDqik+7VaAUU5nS8+azZyW+dJZ/Gfd5mOEzOlfXt8WpfFzpsYwuhWrkE4R5HpNjj5HZAEQ81EUcBJmQahaSG1Fe6AT3aLK4eD6B/6QLGfLqt0R6dzlSG+766DlxrQgNfkzU92R5uR02yYf3WDigz56psj+x3RNiYhPPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaR010Qw8KflOTGlXKcTlyCM7+UieuWbHi2lU+Hw21k=;
 b=i4DDYSE5BG51PPtc9N3DhmPWyVUT496EUfAd3MzrjQDl9KFp0NRt/4WzOZ9KIaD4iAumiyYQ1cYAkoZ5zq6MrDVPToAZg/JLVtFmgZknbIbz19tglFr+6WpcP5SNeLmPGIcuyqI/YLuaSmPc8PYyFrZGqa25YF/2BgDH39HC4YvqS1C0FW3BlwV4LgqqLQJXl1YDlFQ9dmmrX8E3ICRwefnlyZC3Zq5HVBxtyoXvui6cUIE7BAeDzvtL9u+n316kSQSNTe4QjcWNkPuuLnvED9tp9Co894AgGWmJUNrzrO3hWB98V20sNUYcw/AuX+Z+cr1z2IhCqDQOpXvA+dHw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaR010Qw8KflOTGlXKcTlyCM7+UieuWbHi2lU+Hw21k=;
 b=a0iHPEoi2AxpZS2hTMx4sSk+ZNunhpgpCKs46c5VrvWPswAwXJKOdLtiXK9AqjJsp6nDJkI9KzLCA6bQKjchC4iqdoOOAwaV5Ob6p/nAawDS+z7l4yDAh85VeK8Z2Reu/tXgisjHtv6GhxKdeBq4UJsy368aMhX/kaqidhNqSmw=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by BL1PR21MB3235.namprd21.prod.outlook.com (2603:10b6:208:39b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.14; Fri, 21 Jun
 2024 18:41:04 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7698.007; Fri, 21 Jun 2024
 18:41:04 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Jake Oshins <jakeo@microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: mhklinux <mhklinux@outlook.com>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>, "stable@kernel.org" <stable@kernel.org>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "open list:PCI NATIVE
 HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and
 PCI_INTERRUPT_PIN
Thread-Topic: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and
 PCI_INTERRUPT_PIN
Thread-Index: AQHaw8qnHYzFGgGTa02cnbydXb1ZD7HSbe/KgAAcvNA=
Date: Fri, 21 Jun 2024 18:41:04 +0000
Message-ID:
 <SA1PR21MB13178E3D11B407F9B272E8F4BFC92@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240621014815.263590-1-wei.liu@kernel.org>
 <SN6PR02MB4157C9FD41483E9AC7ED9E70D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZnUbWUdVE7q8oNjj@liuwe-devbox-debian-v2>
 <20240621110327.GA19602@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DM4PR21MB36085B06555AF3CD6244ACEAABC92@DM4PR21MB3608.namprd21.prod.outlook.com>
In-Reply-To:
 <DM4PR21MB36085B06555AF3CD6244ACEAABC92@DM4PR21MB3608.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-21T16:50:44.901Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|BL1PR21MB3235:EE_
x-ms-office365-filtering-correlation-id: e2ea07bc-ea33-4ae5-0b6d-08dc9221b49c
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?JRSF12bvLlh1zmRoRQo+kypnOsDwc//66xBCIbKu4JEUJsdb1vC69LhBCN?=
 =?iso-8859-2?Q?8HEConc7xLWZCznozsNq5RMOgUfKnys/sOek0RT8MDcUzNg2C4Db7/pKrD?=
 =?iso-8859-2?Q?K/jxzK6Gf6OGcm6ZEylneZy+KYHggGW9uzcZMLpOagyms9A1w+u/u8PSP8?=
 =?iso-8859-2?Q?Jcgia2Yw6f2vRbnM+EIzyFOfMpDmgbXIxVV238J3NOfhLHVeWWBeSCBA3A?=
 =?iso-8859-2?Q?gX5vP/gdD7bx059s1BFGlYP68f996Yg+6ukRIpS3ISGBjOSzey7lcnWp3d?=
 =?iso-8859-2?Q?+cNOVZacOZJPK/yRsOYsWhSBKoVThqihTWIit328uNbQNfD0B2LSQrsf+O?=
 =?iso-8859-2?Q?LYD2qFDgXLMdidhDFIBn00illDlDhHNDBOZTCjGu9ypSaaRo36SUyCBaCw?=
 =?iso-8859-2?Q?r5DXp776QVGS8qHy1PhhVRNG8uabtME45d2Dc/MK95/TOt+WAFpMJJcwTs?=
 =?iso-8859-2?Q?0twZnXe39l4dsDtNpx0RZeNv9J6fS48Um4kmetIium3fsBoPtrTuCcMjHD?=
 =?iso-8859-2?Q?ik6C6Hmbm7OE2fGRbAbErghW1DLEreElhGuL/kbAD0fsRqZSGteiscxDoz?=
 =?iso-8859-2?Q?u13lTPZX9JSIhA4gIOQmcKUAYAj9O1eVmjyHB2tQep7FWIJsnVTVQVFDJu?=
 =?iso-8859-2?Q?fV200K483FQmwVsfaIPWjLuAuNlp0Ht1j06RpecK+shjjs39daBYtvfl52?=
 =?iso-8859-2?Q?sN9OOpc1ZzuhUk0Cot9137vkSiZK5Anmb9z0/LAxfVeCJki+cfi7hYkPgp?=
 =?iso-8859-2?Q?HHy0v4gZI2vP54b1T0eKE1RPEi7OzYvy9nywfUAGOGsznhlYI5S1OxBTtn?=
 =?iso-8859-2?Q?ttzPxDg42V+E2QIU2s1+pfZrnSqGn0UIMaWvN61lVIh3enCWLwv6gXLEcb?=
 =?iso-8859-2?Q?KGELYAzWSere9iw8JX48viQEJszdb8Ld0E6f8P/zW0VSSWqIoXc7PRAPPD?=
 =?iso-8859-2?Q?m3/AiR1UrLRFUDvGhu5M7e9xpsYPJjtjePw+q3rsjP5aERvzwYjf/qMLiy?=
 =?iso-8859-2?Q?luug8kK1rnBbqfmtwmW/DacD6sHitHguH7YS70wAIER1Z44+Bw6BTHN/34?=
 =?iso-8859-2?Q?YlZgFAlE0HjQDMVv6MD03uo3IWKWLJ/qml2GCjpeLsS81lcDcMhV5nxvZM?=
 =?iso-8859-2?Q?XUM9m9QSyLnPgaSZcVqL5QgEQJMLF0OMdqVxnpOAJaS3szRMnHWz78WOLO?=
 =?iso-8859-2?Q?4J4ouQnMpihsJTlhWz8qRm/P+SeaKfKjUR4xMPofttGUnXioH2EJW2pMEU?=
 =?iso-8859-2?Q?gFDI7s+Ykp3m87j6B1drwwOfyq1NBtCD5iareSksBNb2fLbAfU8xGEfbdf?=
 =?iso-8859-2?Q?Hu1whm0PROPq1HSABXMAEM+aF538W5ccAkHN8lCRHVQb/4FjbWHzF664z9?=
 =?iso-8859-2?Q?dSXRt1uLnLH8lR1hdgu1lRrhWjKaEKopqlu1e2pgvl+U9l1QYoyEcRm/Lx?=
 =?iso-8859-2?Q?7qpB+D6xacNc1GyGNYF20Hggiuqg7HLlkLJc8Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?RGL/PiJ9UC8+QX8lQVF+qwYKQKM3+3/Au+nYOviIf43e7rcPQqwmPmr9UU?=
 =?iso-8859-2?Q?1DKPgpwr1laJT1a1k6Zpdp7930z4QaKfJEH5pDQbiBqM0QGFdt3PYGVjhD?=
 =?iso-8859-2?Q?RTA9T1tHzpsuzOvJtOUbRoiclyunQBHX5+39WXqY4JhTNtnGE9W/95ISqX?=
 =?iso-8859-2?Q?fuULH+VnG2nWW7OGgA2u7KTuLOwoYBtDJmBRSgA7pq5gmdmDKAZNDw08aM?=
 =?iso-8859-2?Q?Ij6BKXn3KUMzz1X5iw4TaFQVQ5oJYpguMB9OIUxvcz2xVto0XdFJZxORya?=
 =?iso-8859-2?Q?ynwDVuQROJnR+2cyVdf4w3Ztwx+3wIsoDU5nyS5YnKRrZIxLVnwVAtQCJE?=
 =?iso-8859-2?Q?v0swrAhtkGTtMwyQc62Tk2jUZSBb3SeQ3/zmcWBGXkmkRUYYJqYM3X1fi2?=
 =?iso-8859-2?Q?YKicVo2IAOyb6ZoL7cNY9gItU0ziSa4HECojtQ8n1VT1/J8iSZEj88EVtA?=
 =?iso-8859-2?Q?8Lu97Vdq4FyPNesUnevxn7WaHaVPXiLywjWSoJIUwsUkfRBOETcdf57vT9?=
 =?iso-8859-2?Q?GhA9SFQ1d65utzSHPzJ2J5cjSiAEmZqM9VFVcnjsxFI+mYR3maE5mkFqGO?=
 =?iso-8859-2?Q?QEvYyD0f7u7SdmptcqKyI5IyfBy5GBe/BMOyUyFYwUL8acsm9R2w9XyRte?=
 =?iso-8859-2?Q?1PWvckplOQiln+JBimvkl2dbJ/kMB0Gbc19WEuIvkcGoQDlIbdht8HIWBb?=
 =?iso-8859-2?Q?JN5R3uQM1whvRMzUbE0kHeKowwvf+80Tde4tT04iDbOgZ42fwyMxkXTOlP?=
 =?iso-8859-2?Q?04TGGtLvIbtqhoLG2rECSRW689R7IqCcLVP0rxIwYnVh5gQdbeQJF3xAeY?=
 =?iso-8859-2?Q?nY1r597UIfJhAVjQXuedcfbBKfyypcAmqQnVkX3+4qjUOsMlgcSPVqPmGO?=
 =?iso-8859-2?Q?lalBTlszFSg/KEoLHcfjHZX5jXTLXG18nqnhUz11uEfv+e7xTJMgnUEgwy?=
 =?iso-8859-2?Q?YjqRAeRhxe+KlfWFmieJsCpXAAyHnk0yBu8439a4ksCiVFom4LuKuVmcEl?=
 =?iso-8859-2?Q?9U/6RXxNPmBVxHlYkIJ9xTpR4i8Dp1hzVKl+ffAbf92d3zfKOS0QDeXg+3?=
 =?iso-8859-2?Q?kX3fzBE5HXGtcjfCXR77n+4CKXH8HuD8wiR455eO1eJyH9sPWsnCCYArbX?=
 =?iso-8859-2?Q?+/fIZoSxTi1EE+wXmCI/L3MU6GDyQn/Y9gS+KIRhxLvYo89s02pW4KiCMl?=
 =?iso-8859-2?Q?n7bsvlB8Y96f3DPeA1HihIGTNlsIYTOIgi31mppItNwHePDJ0BNaZWyP5/?=
 =?iso-8859-2?Q?E8cTVxb3GApZslz4TaWlZZ8bSfOvpnIybwZ+hGsCRf8WRt9eunCBLQrSNs?=
 =?iso-8859-2?Q?hf5PDD4pmRcvbx2/qWbFPkj9n/Av7vXPjgXcdYI7X92G2bMuzBdw6D7YbS?=
 =?iso-8859-2?Q?nJrIxdrNtlLqkli2bLJWcrLpA0jtUCZA9O9WM1yU/m926HxH3kp278iSlU?=
 =?iso-8859-2?Q?1UQAZBKOL04NiiIC2Y5oe1FiFNNbSUUwZ728rO3FM34i2+URYs/p1ZbSVX?=
 =?iso-8859-2?Q?r+MWSHG5wAYu7PdwzLF8aSFWsh5CcF3600nYWKaieY3UnKDAUQqtPScbAP?=
 =?iso-8859-2?Q?GwrGhyWpO2arB4l5JEwRWkBY3UsLvSp5wM1sW65bP6T7OhNh+BSSacA9w7?=
 =?iso-8859-2?Q?kPO4ORvzkfFMy2OAUwrwh9k3XSCkZwLsUc?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ea07bc-ea33-4ae5-0b6d-08dc9221b49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 18:41:04.1340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Dmqq2OoAuPLfdP6eQuDzxpziLv8mfltyJKlpBt35SG36qi1n0aionfwdmzjuFj/FgAvjMj+fLPRy9IQ/OFChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3235

From: Jake Oshins <jakeo@microsoft.com>=20
Sent: Friday, June 21, 2024 9:51 AM
> [...]
>On Fri, Jun 21, 2024 at 06:19:05AM +0000, Wei Liu wrote:
> On Fri, Jun 21, 2024 at 03:15:19AM +0000, Michael Kelley wrote:
> > From: Wei Liu <mailto:wei.liu@kernel.org> Sent: Thursday, June 20, 2024=
 6:48 PM
> > >
> > > The intent of the code snippet is to always return 0 for both fields.
> > > The check is wrong though. Fix that.
> > >
> > > This is discovered by this call in VFIO:
> > >
> > >=A0=A0=A0=A0 pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin)=
;
> > >
> > > The old code does not set *val to 0 because the second half of the ch=
eck is
> > > incorrect.

Hi Wei, so you got a non-zero 'pin' value returned by the host when the gue=
st reads
from the MMIO config page. What's the consequence? Will VFIO try to use the=
 legacy INTx=20
rather than MSI/MSI-X? I'm curious how you noticed the bug. I'm also curiou=
s why the
host doesn't return 0 for the 'PIN' register when the guest reads it from t=
he config page.

>  I believe that this fix is correct.=A0 (And I'm frankly surprised that t=
his bug didn't
> cause a problem before this.=A0 It's been there since I first wrote the c=
ode.)
> -- Jake Oshins

I suppose it didn't cause any issue because the PCI device drivers use MSI/=
MSI-X,
so they don't care about the values of the 'PIN' and 'LINE' registers.

Thanks,
Dexuan

