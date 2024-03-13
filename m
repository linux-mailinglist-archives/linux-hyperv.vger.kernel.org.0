Return-Path: <linux-hyperv+bounces-1746-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1569B87B26E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 21:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67355B28C27
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20E51C4F;
	Wed, 13 Mar 2024 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VWLT+q7y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64A51C33;
	Wed, 13 Mar 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357825; cv=fail; b=E0w4tz/L/uGnWQ58aUI1whRnWSHhmPFpZcHmSTUAuwrbuIJX+ClCe6IzgJR8IeRUjVijPCEc9GaadBN2/lrye6GZTbCw4nBOkM341nh6/fnLQr2IpdPcRz1GcJKE2CfMPuL9ZrvUH+JTwXfoRA3OEXhzxJyY9xshnYAZws/4NZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357825; c=relaxed/simple;
	bh=L6EAotHBrU+B9tSvSg9C8d64DeuDiyqVS3SzVAKFMX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DA4EelGurdiMZFBWAkFclw/SxgiZQZWw0WMpjWnaRN6dVRR5bSwwZMM+Ro+Q6jLTLcPdRC98u8Lj2+toj5MuXkG56QxxBAdY55TFOuA9NHTwPBM9gKcRqXUvCVwb/iPDz8FbUIRWmSTh+B93mi+NlWdKN80xKaNw0negqf5RavY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VWLT+q7y; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGB4N8nB0WzeKu7uSK8JjtElPiBJBFqZswA0rZVHd80E7Kh4s4L6t12C6RYIzmMHFR3eMNFrHXTAt8qdXF4lS5268wW9EyfDLupeL8vyoNkUTYQDadI6ioktc56X4RDb9RBXVBLwvMHlmTh7uM9WHADMUugU8qrVn8JrzbZET43CX9nAQ216w2gF01ELwphRS0M78+4PFWKnDDfXHzJmbantglk6SS+4B6+IJoIjFgJvIwIsyhvOzr4mbhTSDtTaQLGpvHiY75RYyNH9cJrBcSVROQ0CeKcZRQZxGDXpLpUi8RO9uiZ7TKpt/7vDQTw5ET1bsW4McdqVefx1vj5gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLGu38qtdssDAWJwEEQW/luaSKyfQJL7imn1W1e4ho8=;
 b=lg1lQbtoed3R9q2xL9O8qvlOwEJkPuV0oBdatcS6axs+cFdHUYPN/EeA8OApPpwUHwtVOOmBo4tIPEPpgaQGTR8Ohm+bIWHfuqTeTW3xFFtYbW1ZBD416esmQrsY9qYNgI7VyKyXuJLd5byguO/YHv40zHF+2VFU31tNqFhE0yS7H3A3p1ASOXMaSC2xnpiLLtuWcwoP9Zi8h/dxA5jOiuwP5YnIcP6vO7n/RsuvNP8yA5HIozB1dFMfVU+0BGNfJ3aLtfBI90UuMj3EKGeXBVxQOrCephzTOY4rMtVD0hPFMEgr/yJ6OsVCof4LN1GMhziPLAE0wXYjGGzu/W9vcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLGu38qtdssDAWJwEEQW/luaSKyfQJL7imn1W1e4ho8=;
 b=VWLT+q7ykxSpXls6VeYX/pet/8NDH8r+Sg1PXrw02YCQp+knLNItHXeieJIJY0DI0RQtuCNfodWeYwVhAeBT34bRoKtn/8Z3IysswZmPlGq8iOLBXejgZCpdlFY3A4ioUV05rjJlmKf/Y5C1oIkCim4HO5428pphtIHVy1sRQpg=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by IA1PR21MB3764.namprd21.prod.outlook.com (2603:10b6:208:3e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.6; Wed, 13 Mar
 2024 19:23:40 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.004; Wed, 13 Mar 2024
 19:23:40 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH 5/6] tools: hv: Add new fcopy application based on uio
 driver
Thread-Topic: [PATCH 5/6] tools: hv: Add new fcopy application based on uio
 driver
Thread-Index: AQHaYcveJqzl0fBlskqJxgmvLkLRWbE2MYhQ
Date: Wed, 13 Mar 2024 19:23:40 +0000
Message-ID:
 <SJ1PR21MB3457D926702F158DD82BD242CE2A2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1708193020-14740-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|IA1PR21MB3764:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 a4BhQ+WblXEVS2C81xMpe8oCh+E23gG96SCc3wrcm5bh9QB8OZsktpXKySACIi5U2K3YFMi/KFjSn7c6H2tMPHu3qeNeNG7V7BLHoG3+VgTDwutQGjmyxPEcgO/Ql58qPEd3PfQBDb1CpV8RB1x/VZSnC36viGVgXrcu8A0H9ifWQC3EaH+0CCLWuOO4S8PW6tlWx9KiuOJFs8vrusSC+IdPMvrxFXvXFRlP5lMm24r/poZBwctGgjzTBZaPKxZROZAYZpreED2+nnSn+X1K34h8tQyqqobqdZRFnoP4JL7uVhurHHdlIKnQ2HVJ98nmRa3Z5RXp2+cYGXHUykSBSKbic9Tiuu5hs+Pd6LKhfmOzVFMr4sLBh6SlQHOfJ2M495cq4UT0jPYNu3zpJfSp1kHBfaibmPeTyLDlsJdAo17/Z3Fp27Olq3rWpQgccnr+DDU9wOClEgSX/dHsDr/6UYgQH6KKPAbY6drioCgGOevHKTnRxCV6rq+CMCLzjaSpISOvmMJ7TST0kbe+U7IK8AhoTtcLtG/dITHqOt8/3XSYxYqu7h+DgtvFFLCAdKmEQE4ZlsetpCbGNGKKEp4m1wxGRg1lbg/JOD9S6Gmy7D2P9aglbnJVgtDgmEsjmd4YAEPWqgdq5T4mQGM0qdKhEV79krfpsP3rW0EbHlwtMB0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dbR1/bSgzb/JbOYERDOP/yL7lRtgLPGvx29MB+RPAmXVjchn46bBodgeuKHf?=
 =?us-ascii?Q?+czc+8KnDgPQO9uuuN4e8+sX3eJB8SKrmtS+0f+SjP9haxyDIAnsvdQakzvl?=
 =?us-ascii?Q?1+PNGseWxlyOHKiy0CC8H5H6R/5+loBRykB+WRXl/LL2lxCQfZlKKit9Djya?=
 =?us-ascii?Q?L11j9XSxQkLdqCJYQmKoKcGOgCwQcft79UCINV5ZRvnIl4G0qlt9dtD983gv?=
 =?us-ascii?Q?IfBQyIlg/6xE/yqoV9B1MQ10SZb36j6C3+w5PrMCKeO4L5X02n7wQUmtYqJk?=
 =?us-ascii?Q?7uzMGVQy+nRlVkAI5FiVHNZ8KzlMoaEIfbIIQq4RbZYheGMIk4WUiyTh7Jiw?=
 =?us-ascii?Q?0Q28UNW99x7b3BfMO3OTe7QQdfRZ8qEzujcHN7NKetz28KdrUbjZIX+YXRek?=
 =?us-ascii?Q?dJMdPGwKoxcnNUgL/clH9QfEyGO3Mtl6VHWn2zFXwNIJVdr+a1+9uC54gcr3?=
 =?us-ascii?Q?kfOcBPP2xbqcN3GNpLIRWQnmbDP/ayxmW7o/GR8XSfkML41uqz4rCAk2Bm8b?=
 =?us-ascii?Q?ZeVSTNmy9EMhDTbEmXFc5KjRUJNRA0ILXxjGnrdzojwSodI3yxLcR7v4nTcR?=
 =?us-ascii?Q?HGiX600IsVvY8QB6i/4ujFTh0QnZckXc2AOxHk6T3eI+OYgF/uVE3AQzAkVk?=
 =?us-ascii?Q?JkE9t0xQiFOO6WzKLqOPseGK6FoJQu1HaMaSN9oMgWzUR9EGO/Djrq2KGac3?=
 =?us-ascii?Q?MzGQBajyFa3WpfS9fmMUPDbc4Gs/f6JhcRggSICEWj4ZkfyHMm6LrLMZsQaD?=
 =?us-ascii?Q?HkfaW7E4+YhvlAQ8Sh48Dmqv8v+YzR46wBlteBydxSpBvy5Qo/kl1URety2J?=
 =?us-ascii?Q?8zo7oaTKV2ScAKOYfOdYAxvxoKtxjG2EKYI/F6j+tQkVdmA0zE1sY48ZdET5?=
 =?us-ascii?Q?ad3KOt30svbIJPMswmqR+vN/G54wNPnbbsUwkfSia4hwxy2qg1XtaMmy8LWZ?=
 =?us-ascii?Q?yJAAPcbXOvHYaXJMvyq9mEUY0Kf+F384B68xxvtR+kZiZWxvl56wQZArB15i?=
 =?us-ascii?Q?CoetG08t9vvj/sX9W9UBI9rd9h1CkPgf/77VYNKISf0Z9d5pTnKePh4pWDiB?=
 =?us-ascii?Q?oLEqL5s8e+3sJ4jsYTHqA0Y+kdMhcGSPl/THrngeJrC13Qc7LuqzVNYgoz7t?=
 =?us-ascii?Q?wsQk27/Pg4/IzSfTAhCWFZoSPACHLD/r18oZdrVhNZyz7TwQVaxrEcJHx33w?=
 =?us-ascii?Q?GXd1BM41JID4LBGPDnV59s6SwtEMRzpPOWkmMN9U+nPkyZit9t7tm47qApE6?=
 =?us-ascii?Q?UFwkryGAkZDUrOF/D94BxQl4VlBqqP06gz2kUshYPaLJQraFoYPsODsX5OzI?=
 =?us-ascii?Q?BMc7wfzunFtDqfK86U+uZ/j1utulbCX68OVpHVoYPFQwnknbErlz5a8tDSgu?=
 =?us-ascii?Q?Lw/x/EqIeaClCaSZ32tQc8C4H5NzEmpV8nzN0dCfjrUfMCBjrpNGbHUczdZE?=
 =?us-ascii?Q?/Ucp2iCW2jlReC9L2sJUHiJFMYCc8/54w2zjG3oDGngzlqwMlHeYMvE9wRs3?=
 =?us-ascii?Q?P/EPuHYm5jlhgoihT5KyqorcYFi0WuUcMkWm/udr9M+giicv+xsV4OeJ7Fsg?=
 =?us-ascii?Q?EJQ38A1N89Ks+KbYdLu25so/u587mQL0aU+/doPP?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ef8d84-d681-4bff-c309-08dc43931737
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 19:23:40.8262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDOoXC1e+U4rY3NaJzp86NrEOuHJTei9WWhGKaBubH8EZeO8kPYIAU6ZPlgmZkjJ3V7gRdR2AJouqL3tKuWyIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3764

> +			/* Signal host */
> +			if ((write(fcopy_fd, &tmp, sizeof(int))) !=3D sizeof(int)) {
> +				ret =3D errno;
> +				syslog(LOG_ERR, "Registration failed: %s\n",
> strerror(ret));

"Signaling failed" is a better word?


