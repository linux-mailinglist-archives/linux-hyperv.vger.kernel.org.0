Return-Path: <linux-hyperv+bounces-9777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDFWCsZKxGn5xwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9777-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:51:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8583832C024
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71FC230467CB
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93B313277;
	Wed, 25 Mar 2026 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NEo798QA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF030DEA2;
	Wed, 25 Mar 2026 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471660; cv=fail; b=eSY91543hqpRPJAdAxwzRAxat2Cc/hDHKaSkd750ibFkwM/SK3bcn9rKhqOFi7S9+e5KyQ2ECYv3IfuRhgiRkjBBwC72DSTBXaekQj0FrSOUKcNYSttX8puLJ0idzZtXz6P9VKJOSo9zOy496SRwHsWjcgNGByWGu/r5OqA9QVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471660; c=relaxed/simple;
	bh=CMh6TeV7tQ3cQfhfAk4cx1TudtjUifm2Nqqw9ltNAQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DEcwS4EUKm1FmfhrSF70cdGJAiyQheTwN53QL0zjr5DWJMMCVFOu3dNt0ayEHtYi/5mN2f10tXL4odhf8sCT/MjEx/FbzibvFi6ry+lGX6z5fDo4K4zH1Ofnv4a7MvQk4gZLHYNb1h6ON8h/CWkqMHsZl0tRB7TmkdcZftrA4MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NEo798QA; arc=fail smtp.client-ip=52.101.62.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtJX4c/kwR8qRmqB5DsCuNwBjTizdguqfPxoLgJuVJWJbfizejUCdyGRRXstYlVjOojYhm/gdNBHn4Fb47P3srpi3BnYzVsTOjYDWDVq4wksLn/LutDD/CPWlYxLCZqqXwNdMvYCrMvQCPXVpIK52Kt6+Ty9Ot/+iR+0DbMLRKHbonyqExwh2WLBdV4oAjVPZR2qQ30p9k4LwF+JLmtEZLBd0GuOo5mcFrErdYXuUSU2dSPAsUwSSqx3Yje11icILxa2ODsvYFSqXDpN8UXR1ghRjdjF3XP9nMsv4VyCydHv3Fbkf8IIqL0bNMQHec2WBuW1TXiYaXG5eaqGisg0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMh6TeV7tQ3cQfhfAk4cx1TudtjUifm2Nqqw9ltNAQw=;
 b=LS0+cz+9pwcGg9cQAFY7mbqYOV/3wNAgRt00zWSCk/nXej02i1RO9QOUl/NFQq+mj/+ddYm6mRjSiTZxXQ1wV1V7kQ2caUSsSClU9u/5WIUIDOg3Itz1A4fWlkPROu9i7Ww0chvhz7WB7uelCPwwaq2INh4WPtQrjs3q3e7dAzAqbtWFbjnXCgc8Su8S9dMg1ICBgI2g0+b7P3n6G0fGIWnGzkbfhhfJBrdudJNTWwBuOh2/j+kIqG+nnQ3moxdKvG4G7AbjygeX7h2+7lq4P1O5TpCUF/3B2bkhZEm2dRprjkPaDcIfrf0kKwkOk+RO+KxJ+UqHdVhSuSmEeviMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMh6TeV7tQ3cQfhfAk4cx1TudtjUifm2Nqqw9ltNAQw=;
 b=NEo798QA2mrmWTz07I3o5rDAsQMJUEiYIf2ZLR8amSbNJB4ps50k5SsvEagcLkLCfZCdjRgZDShMBEbxpoYjn4UEd0EGvtU8TYs7huR6MmwB4A22bpyoD5IcJwUfQnVtGl1PJgCIML+dijDItOqAGkA48dqDm4qbYLsftCHmzL8=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5697.namprd21.prod.outlook.com (2603:10b6:806:498::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 20:47:35 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 20:47:35 +0000
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>, Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v5 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v5 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Index: AQHcuv+uY0rQdFhn2UyizOQL5sQArrW/ersAgAAxGzCAAA81cA==
Date: Wed, 25 Mar 2026 20:47:35 +0000
Message-ID:
 <SA1PR21MB6683FB2D67A3BBCC74B62D45CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260323195952.1767304-1-longli@microsoft.com>
 <20260325165646.GH111839@horms.kernel.org>
 <SA1PR21MB66838DF94EC752617C9FED20CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB66838DF94EC752617C9FED20CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4cad47e1-f906-460b-926a-2da47ee79709;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T19:52:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5697:EE_
x-ms-office365-filtering-correlation-id: d0182416-3ede-4aac-8016-08de8aafbe98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 xsRSbk5f/uXtP92nYISp7IOmRbK8W1OXODrFaFiOUJJKOHE8P/k/k1EW268aIXsTGZ8kwUkJPh7pVr2zAPIFXK7WYWg4A/enWLK0QHSU159Pk8QuZtkx+nPbZqo/Z1iJ1tawdQmzoyVc0rh+B5mODzJSP6ozVdAFVQuSPJG26ZWc7vvr58Bn/bK0OLTqF3dYsNCoDIZ1zuuFZDb5xpxNYe/yxv0zRwACTgOHU/ARUWX25xF158uVRIcbgpf2GUlmRm9mbmh6kx6Y3jX1xhJ/y/WSD1yd1ZdG99LldiOH8uNps39QqZ3X0dT0VmRXo3EGGcDKdiTLQbgTD8OE2Rolb3leUCgoDb8RbYdABCgAu9diqqs6Y80flaMn7ELqycKlHMqDVL/hlEiGASyFRo3oqDE2Jg8QJ2GjHxygaXSMTgLh/VD5dXbXhxGJUIORuNYEL9zGGgAYLmF4fT91IgBDf9xF/BdU0NuwlCYYQLoQXOmd5jE9BUhzRt/iK37FC40p67hk9eIYMzyF5AVjf0MBcbChAgRP3xKvi+Ynz821gAoEO9MPjBN3GqwzfJhkUXN6tRVxLDuU9evcMaQL/ewWllzrTtkRrGVBneoSs3Attuym+FjDypyIQHR9ceLuAJNZraJTN2HbZQ0oGrQNCaxTHHn7FktJSEnW/YaMB/DG66iEE9RzPYgpFrzbgxbyNQrN7ciAMLtSBa5yK7BrQI97E5QwbN9M+99NvOxlO+BMDC25m9coWaxmUTuWD3stJ0tqUNPCDatZurqRSnmvxYSq/Ww1s1r0XjIxBFAgBqKDVmk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9GyVgZusTyHa/tQU4skUC3TCc230dGJFeHoVFYEsuguKw0GVlYye3x/+gFDl?=
 =?us-ascii?Q?HNRHO8pIBs7LmnlQeLuVMUUobrj4ZnRTsqA+lhyFB3j4X2Nl5R9e6/Sv4+V6?=
 =?us-ascii?Q?9Tv1rsoE2Iw+Y6JkHSqkPiD9XWEeUpod7rK05+7YmZlDMo8LOu+A7PHI5A7t?=
 =?us-ascii?Q?jBsQrNkOCjgpdBajww8k/ezUk1SOaQlcR3SLszIdsMZv9vWUfUOBVmHOK3wT?=
 =?us-ascii?Q?Q9ZqqFdLwMpLcYUuMuOUSYOQj3TBbpLxJJ1KQ1W0aBM6XsgCpiwYab4LKW6F?=
 =?us-ascii?Q?0j39F+LJCxP7VXysd8XZm+Mt4JNwJcp3nfdC9V6gmds0JI9yXOBdEqD7ZJw5?=
 =?us-ascii?Q?cMoz3ILEVKCY3iCOtBhVQWb7ttQKxH3VmtKcDXM9MOEuiQ2hU7VyW87QI2P2?=
 =?us-ascii?Q?QFNdOM/HgPci1asknvgPxk9BBPXkKhvO4I/dE5k82GnWw/oHO7hwJPzbmyhp?=
 =?us-ascii?Q?RuPPKafHoyparZB4+YZtsYVXsrGcVQqPKfPIu7PHwC5FQbzNjLS+pTmKJYC7?=
 =?us-ascii?Q?BL78n+8Xb84xpmZpICytch5MNg5tAekVMboXx4tN/H5PtX5flGOMRgggSEBH?=
 =?us-ascii?Q?eMzpGl7PGuR/9X8ufg9Ny+LvpkudyUK6IUZLMn9t2OBpzCryyBR/s361qS9j?=
 =?us-ascii?Q?AILNHl7ClQwg0+2ozgp7Bh6lOWr6940CxVLzVvJB4gLXF3QpOg+VzkAX2JYk?=
 =?us-ascii?Q?HEQMGgnk+56ypEKONEG0XcPcbTikju8qil0dmdkt4dn7m19l0fylMCpXQQgB?=
 =?us-ascii?Q?wxFRs8Wwixeg3hyNYsDIMDkDgUmJVmmIRr8uyBUCP8juiLQgs5P+IpybA23b?=
 =?us-ascii?Q?H3SJOdnJnQWAYedlipwNq8t0HLuk7NPYOdd5vUpRXcmkOVua+42SKiD+o49l?=
 =?us-ascii?Q?Nr5at1OrKYMQk1KXWeXCCULDAfX45fkzFM06V9Gf+gxcejf5b0OKfRym6ORl?=
 =?us-ascii?Q?xKjlTn+rSxT0kHVBogsjMjpMg/z3uusXMAEPfjAed1wAqIg0l7k5ye1FjhXM?=
 =?us-ascii?Q?NgYkNwNuLoa2fpir8FCMX00c+edn02vaWunZYl7mSIR0tMNthhdeTv2vgxQP?=
 =?us-ascii?Q?xusPkwvuQJzOkoF3u/6jPaxDDe9UnNkVwQ8qP5P+rtnO93kcrA8Xpic4R8jF?=
 =?us-ascii?Q?/Avd//EN0TiyrEcAwbl5NzjPxHnYs9XKSXwO/6bFoY1hM1ugo/LuC9BL26cg?=
 =?us-ascii?Q?ebZymQ9pc4hN6Ha8r71NY4iBtgs3OROSQ8sXyuRASNiw3MUbY7UJ7xEIJT3c?=
 =?us-ascii?Q?j5PQAFtLN/6oZv3siPOgXkXc9NPgY2Ol+tPAHSY3X2wUqfPIoK15zTS9phpM?=
 =?us-ascii?Q?PwZN0A1bxD6eCbWYRwonxSWnPhigVAtpo0xmP/OUdK2EYjo4D5yn5Td0iieG?=
 =?us-ascii?Q?+/p1TwDubA8p3qjs/3Q4DhG2kFjSCLJZLhxWhBQy01dx5Y0WB5x6AZIQonAV?=
 =?us-ascii?Q?Q5KrwfnbgCIEdL1Ov9HkrnTwnYb1nMLkcCk6AFrJ0IUN+Q1HKB9JlBA6ubdM?=
 =?us-ascii?Q?cv5IepmG87Uh/fF7HQfy3mu0jrPbBHQDmH+BeiwCzRzW3bZ501n9WkqD1wJW?=
 =?us-ascii?Q?VGIbm+f2y7m4z7/8KuriUhBhLhFm6lsQzkzmAfk10AX1+6gp3G9v6iWWXqYo?=
 =?us-ascii?Q?Gk92wnVeMMchC1uXg2JAQDOi8tkAOz9gNFefi/csmimVvYQ8YyNqYSb7Q1dn?=
 =?us-ascii?Q?iNxOqIppcbVkys7N1UBgyWoDPPLAuS7GGCV8MxxNeio40oop?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0182416-3ede-4aac-8016-08de8aafbe98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 20:47:35.4560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpQMZgkE9DenQ9iQnB/iDsgnRNpSSlL27tSyXsXOejm6xlJbeVsp4aCoOzQnVioQfFRVrijEm8l8Mjn1JuJaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5697
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9777-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 8583832C024
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > On Mon, Mar 23, 2026 at 12:59:46PM -0700, Long Li wrote:
> > > This series adds per-vPort Event Queue (EQ) allocation and MSI-X
> > > interrupt management for the MANA driver. Previously, all vPorts
> > > shared a single set of EQs. This change enables dedicated EQs per
> > > vPort with support for both dedicated and shared MSI-X vector
> > > allocation
> > modes.
> > >
> > > Patch 1 moves EQ ownership from mana_context to per-vPort
> > > mana_port_context and exports create/destroy functions for the RDMA
> > driver.
> > >
> > > Patch 2 adds device capability queries to determine whether MSI-X
> > > vectors should be dedicated per-vPort or shared. When the number of
> > > available MSI-X vectors is insufficient for dedicated allocation,
> > > the driver enables sharing mode with bitmap-based vector assignment.
> > >
> > > Patch 3 introduces the GIC (GDMA IRQ Context) abstraction with
> > > reference counting, allowing multiple EQs to safely share a single
> > > MSI-X
> > vector.
> > >
> > > Patch 4 converts the global EQ allocation in probe/resume to use the
> > > new GIC functions.
> > >
> > > Patch 5 adds per-vPort GIC lifecycle management, calling get/put on
> > > each EQ creation and destruction during vPort open/close.
> > >
> > > Patch 6 extends the same GIC lifecycle management to the RDMA
> > > driver's EQ allocation path.
> > >
> > > Changes in v5:
> > > - Rebased on net-next/main
> >
> > Hi Long Li,
> >
> > Unfortunately v5 also doesn't apply cleanly to net-next.
> >
> > --
> > pw-bot: changes-requested
>=20
> Hi Simon,
>=20
> This patch set should apply after this patch: (which is also pending net-=
next)
> net: mana: Set default number of queues to 16
>=20
> Can you apply the patch set after this patch, or should I wait for the ne=
xt patch
> merge window?
>=20
> Thank you,
> Long


I'll send it over in the next patch merging window.

Thanks,
Long

