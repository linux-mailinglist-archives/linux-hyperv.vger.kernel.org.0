Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB294720CA
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Dec 2021 06:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhLMFyW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Dec 2021 00:54:22 -0500
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com ([104.47.55.102]:6436
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhLMFyW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Dec 2021 00:54:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Pf6HowNbRdYnIvafO7W0/jYnogyusQlUcriIn/SWV0wpry8MbElLQMVWdWn7f3hebI4jznuJhkiZbe8Kw8KeCaDcdMFAc3Eykx/yI2XK7H83sswvkQ5PtNVLTC4GKcIBEIdySz+PWNQsyG6pAGts2KZe9rItr5J1plcCZyMIazNcNR9Yq7tteSgg83jQWz6hROy+qVYtOClWMAIQhMx3HCGAxbZOikTM4h6EAdc67VxUGppO6aGNzOTxtXFm+Iq01OGkiVsP29ScP8ecZfNGvrFIHBv40sd6ppUWwoLX+pmNET752+yY+O+InyZhcQO8YPrg9mcCxidUbdzL+Z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvLzG3gZpeMncXgdlugOKWYaHvlKvusFJ2YzKG2XzH0=;
 b=KEYHgkEVAjTYDvBMNYSoIkFyn8/M3ABXCGM5IDIvIQ1BUOBo3I+sXr8DTKSA/mk74mIi92lipLqYFUY1+bRJTWx+X5jFRsM9gtStZ+kEnd6IFpztag1bw6DToL66rg6ee9NFj73Q0W4hBxnzUl7w6H2IS0yyhfQy78rziZALDsst+j4gYsgEwNd46n3YNO3iQlSIM2ckQTPiHjcQN2fLv1auJA4aoLyy82KRSoYxdaPwLX8xRm+/gfLTrZ8JWhBDLV0ahc0MjTKZYddMWUM2xie+pyo5jHzayQWzQLvw9Zv726JMwQH7qjsvTW4sivXMi6GDcma+1PzzOUJiD3WNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvLzG3gZpeMncXgdlugOKWYaHvlKvusFJ2YzKG2XzH0=;
 b=VE10Q9rfdOmnzxcxhcMFbzhtzBPANDuW5cDG/in0e3B6cg33cUC72l2Yyez7EYzmoax1R1wY8PjYWe7A/XMuQ5Hauz/MctlLNoGiOIrV2gomwVv+WKYdruuuKq3VU8nJByQEYHXwqXYvv4xcBi9IRcE2RBP4VkhGho2fHkYAfyo=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM5PR2101MB1046.namprd21.prod.outlook.com (2603:10b6:4:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.5; Mon, 13 Dec
 2021 05:54:19 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e9ea:fc3b:df77:af3e]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e9ea:fc3b:df77:af3e%6]) with mapi id 15.20.4823.005; Mon, 13 Dec 2021
 05:54:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Deutschmann <whissi@gentoo.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: hv_balloon: kmsg about unhandled message is killing the system
Thread-Topic: hv_balloon: kmsg about unhandled message is killing the system
Thread-Index: AQHXxcSnCxsecfpVFEOErYPybSIxYqwwPmDw
Date:   Mon, 13 Dec 2021 05:54:19 +0000
Message-ID: <MWHPR21MB15933A43B20C1B52F0B0A90AD7749@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <4d9979cd-f2fb-bf65-883a-258a656c08e1@gentoo.org>
In-Reply-To: <4d9979cd-f2fb-bf65-883a-258a656c08e1@gentoo.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b725371b-13c0-4983-8b42-36d3e78201ac;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-13T05:47:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fbc7ce9-4f86-443b-35cc-08d9bdfd0177
x-ms-traffictypediagnostic: DM5PR2101MB1046:EE_
x-microsoft-antispam-prvs: <DM5PR2101MB10463E30179B614FDBC69313D7749@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HioqSd3ru+WLMsLjNREqxUyAEVTFs2PiwFymMdmrSIfVRnIZ0MTlGTo/jEyYd8aDC6NWaC4171+p0LVN7HyhoqNDSc4Z9gbOX73gutDYtflj5hXjVRDwYppkczIfVLCQVGs9ifR6CqbLszh+bTNHoolDOMzqkvZHJF8TvvdFiGGcxejRyWhkxPPR9stSCN6JqFswb4ygrBRtwVBAaCHYf+Cazr33wWgyEaIlFkbpMo9pfOGB9NdOog44r1u4POJB41g+p2lPSCORnAlAofLnx75sV/Pb1+5vo8hHSXQhWaFr0cDUe3WbP3i3kRJ5eXz02NKPsr3QDE4jPwYcB8lFP7R2OLMprlpWoaGZNT+AlValztlDedHBpphQysJlqLyMyNdsqdFeZe5n3XJIhw8aciaDlS0YbImzResvgeUrsWdfgFCfn+/JGnC3bh/8d8Jnyw8SpgLjFNzH+sN7JFMsKiWryyQa/Mkq9BCzN+0RUnJWvuBv3V+QVnahlc5MSD4DzQEM6W7X3AGthE3s00QSoCxohcaQJdDWV5kxFrCGyHhCTDHh1sCvbeI7OHYwMduqLs1ypEvmrPkI9564vfaUqYKFPJlPv97KIjEPkOaW9yvs00stHG9ahzwjGFu26U07k1La95OOTfLhfMMxN+NYSMHniXVAO/N+DWpzq5FWC9+qdynRPnHEfqGESjjVhkMsH+B5aoM/G0iCNCWnwMGooj25yhjjhAs+7wQY6IwN25Cx85Ia54yOKmnyed7K6QSIIl1c8fdlCv6EIREQ1QIrDo3cVBecJdzmAdKytiawwMBqwkH71juClvo4e/fB3oMPiTRTOA/GsPvOZb4XTr637w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(53546011)(110136005)(316002)(9686003)(38100700002)(186003)(26005)(66946007)(508600001)(86362001)(76116006)(10290500003)(71200400001)(6506007)(966005)(7696005)(122000001)(8936002)(82960400001)(5660300002)(83380400001)(82950400001)(38070700005)(64756008)(33656002)(66446008)(8990500004)(66556008)(52536014)(15650500001)(2906002)(66476007)(8676002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rV7JGUXUHRxI4uo7cGttTJjZr+WAOzQJXupD+Bgb3Mx1QyzTAbaSueTOSTML?=
 =?us-ascii?Q?aXWtiVAC4DcJFL5+UTmw59VApJ5YfWvUUYv64SMTy8NkkaXEXbXety3+/idK?=
 =?us-ascii?Q?JZTm/puD2B14jnxxNpNpmegs7kXcs68XRwHaYo/yOtI1FHJHzhMuRD3DYEu8?=
 =?us-ascii?Q?2GdEtxmTCnPSoXdVJsWUuqCg1yK+tkqPc9K0jfvq8YinQU+/A6C7Ib4A1Hza?=
 =?us-ascii?Q?WNKHf9GzGSv3YW816oBj7ckj++iMTucOHTuhYBVvKFji1Ttw67FPYZsi+D07?=
 =?us-ascii?Q?wFk5TOfJi6mZ/BRk5jYgZFJr9mOhpZ8ULLJ2lvkhka7SpewLJUVHXA7Hzebh?=
 =?us-ascii?Q?cIXQsOljv9ccJSSHrRhOeNNLhStG8tKGS5BT7Ff7OpnY1W39N+ynOrvz4Yoa?=
 =?us-ascii?Q?dP57oca2isRx0w9K5qSUd5QtNjpCdDJj4sxIziuNTFdQFnUh11X27KGIj/mC?=
 =?us-ascii?Q?nIkH1ysbYIhSKWxdVFipH21l5c2gUsoaBMmrX7bSO7TX9lI/zjmMRkCbVHXr?=
 =?us-ascii?Q?hY5I8re2UXEkMfdKMnRrcgIfqat4f2niKn4Af9oUNI66QklOa7iYBmR+Rhmh?=
 =?us-ascii?Q?c0cr5HU0gwmRfJCQP/5yrMtrlGE2gktaxl7kOpoZTGNvHG0GeQr0PCzyvfZg?=
 =?us-ascii?Q?XU5bt/StDYj7N90O9k8Ep9KybrwPkILRZlS7qWQTvCtjek7zaJwJxquKJ3Vf?=
 =?us-ascii?Q?msrKGpJ1qIlDAkswn+o2p73srt70gLWDKEv/oJDVUwkKCG8DcXynzTaoNJPp?=
 =?us-ascii?Q?SP/Ox/VgcHhpWVIWD9LiIKmi4QmVLM76sUr3FpQOPjn29wL3+2aE0H7FN+dD?=
 =?us-ascii?Q?RbmBhRT79YGcK0nD+eLDIbdGqro2pyRMyZEyqyQ+r3ajKCAMTA54bHuxVxQB?=
 =?us-ascii?Q?RHonfOWqMwJBtNBjflte26BitSAPmp67OAmiSW8Sb9XPVZHrRI2IB6sWTu6C?=
 =?us-ascii?Q?6HhdI4+JSC5bt48cqqbOsdzhyjZvFjtSUHOwVBTbiaR69jRt6BFX7n9jP/jX?=
 =?us-ascii?Q?HA5V2ZTRcZrzvf1aHifHeoGLaqejnyRpX+JJTKZfAulPI3/I92RSIXfhgXR5?=
 =?us-ascii?Q?c+2OYltuOoumqCin9w5KuVpIBwno68/u5P26Ra0Du4YXw1hcZFc7ciZSQMP4?=
 =?us-ascii?Q?/pBpYJgtKUZFN2SU326UWnrRaeWLnSWnyKeFDXkfk7lu3hGr4rhFFwyECJU6?=
 =?us-ascii?Q?18g4rljQz1wykiFneVBTq30GIUk4B1l1TfAnX3gsnysewiSkFjiOEj4A35JT?=
 =?us-ascii?Q?JRf/lp0vK8/dm3ExAly0kE+FUCYTN0J2lQJnKFVpmrtvkIOph0xOPp1Px5al?=
 =?us-ascii?Q?+G3unnrPpIiZXh0vSTKCQIi47ZEWrXfOuojw/sY3u4k+GigMK4mMyzhrLRwa?=
 =?us-ascii?Q?oWhpN/C3TNJ7hvytis2eET2M3N9r72aiwOzTVYbaCCuWXu42LfO9c1ykwsRT?=
 =?us-ascii?Q?T018AxNWrN2nKC6xFwwWzMt4r8PE8jb5QiAOQA3AE09B/bUmlNfEXPWeTo3H?=
 =?us-ascii?Q?VSMaImaiaALqip4GAxV3kFZH/5qjNVYd5uKiRmOsPi/541D5H1jbXc3CgJj7?=
 =?us-ascii?Q?TDN4kU7vjQSODpbBqWW+BDzye5ebWviSQ+8OFt1M+QCNi+NsigDhg3/6wxib?=
 =?us-ascii?Q?iDNipvosMYIMxOqb+Pd+zMvvq+gOknDKnBxm6M95dazyplNMRyBuAGHv8Zxk?=
 =?us-ascii?Q?TO8HAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbc7ce9-4f86-443b-35cc-08d9bdfd0177
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 05:54:19.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPv/Fz/bmG8r22/Om2d92Bg6L31b3xGImsMwiJ+qUaoRjf+eCRdNblI5MalFe80InTy2dyk3d/X0WsK3LgoQKh7f8dQ7rQpfoGY5gm63H44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Deutschmann <whissi@gentoo.org> Sent: Wednesday, October 20, 2=
021 8:10 AM
> To: linux-hyperv@vger.kernel.org
> Subject: hv_balloon: kmsg about unhandled message is killing the system
>=20
> Hi,
>=20
> I am running a Hyper-V Gen2 VM with Gentoo Linux where I make use of the
> memory ballooning feature (8192MB RAM Minimum; 61440MB RAM Maximum; 20%
> memory buffer) for almost 2 years. Since kernel 5.14, the virtual
> machine will sometimes log _a lot_ of
>=20
> > kernel: [ 1022.277623] hv_balloon: Unhandled message: type: 0
> > kernel: [ 1022.277624] hv_balloon: Unhandled message: type: 32768
> > kernel: [ 1022.277625] hv_balloon: Unhandled message: type: 51200
> > kernel: [ 1022.277625] hv_balloon: Unhandled message: type: 59392
> > kernel: [ 1022.277689] hv_balloon: Ballooned pages: 1519104
>=20
> messages, causing log mountpoint (in in my case root mountpoint) to run
> out of disk space which will kill the system in the end.
>=20
> I have never seen this before with any <5.14 kernel.
>=20
> Of course, I tried to bisect the kernel multiple times, but I never was
> successful because it is not easy to trigger the problem. What seems to
> work best:
>=20
> 1) After start, wait ~60 seconds for
>=20
> > hv_balloon: Max. dynamic memory size: 61440 MB
>=20
> message.
>=20
> 2) Now allocate some memory causing the VM to request more memory from
> the host system:
>=20
>    $ </dev/zero head -c 22G | pv -L 256M | tail
>=20
>    (Note: You have to do that slowly because host will only grant
>           more memory when memory pressure is constantly high
>           but when you are requesting memory too fast you will
>           run out of memory)
>=20
> 3) Now end the process (CTRL+C) and wait until the VM has returned
> memory back to host system.
>=20
> 4) Now I start to compile chromium and firefox with 20 threads each in
> parallel.
>=20
> If the kernel is faulty, in most cases I'll see the kmsgs about
> unhandled message types within 10 minutes. If I'll get the message
>=20
> > hv_balloon: Balloon request will be partially fulfilled. Balloon floor =
reached
>=20
> it's usually a sign for working kernel.
>=20
> But as said at the beginning, this is not 100% reliable. I already ended
> up with a kernel where I thought "This revision is fine" and suddenly
> the system died because millions of those messages were outputted. Or
> sometimes I am unable to trigger the failure again for a bad revision.
> See my last bisect attempt:
>=20

My apologies that someone did not get back to you sooner on this issue.
Someone has recently found a bug that is the likely cause.  See
https://lore.kernel.org/linux-hyperv/20211213014709.GA2316@anparri/T/#t
if you haven't already.  I think the proposed fix works, but there may
be some additional discussion about whether it is the best fix.

Michael Kelley

