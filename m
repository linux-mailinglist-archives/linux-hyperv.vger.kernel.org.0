Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94BC5476E7
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jun 2022 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiFKRhC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jun 2022 13:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiFKRhB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jun 2022 13:37:01 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020022.outbound.protection.outlook.com [52.101.61.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985A7634C
        for <linux-hyperv@vger.kernel.org>; Sat, 11 Jun 2022 10:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiBdOGuv5lSppTM17XqqBoE1rPPN7B9xiO8fU0PJsKtiiQ9CzUdHak13c9ZZdJWM9kwzrfBq8tb1yx8puQdSBSkQZonQHMQ7gCUDTMaM0dv7kj7pJj+0e7c8AiTWe6jsbuBPG9CjiEQwBJuRWUfo666uRMs6nl77pIsndWUHngG8AfCQ3KWCVfrf1VoFjyBjWtfghLJ6hEI8eyKTPTj92CpNNgZJkOCu8ycroqnVTGr7JVeVRwxPdE62CWLQzVhoOrjrrCXkZJAEhDdLYkGrmowsu8O0Hy5wizJiMtBB4N7gs+UJw/JSzLRNdv5yUIb96GOZiSMXG3INutCvrjO6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uejTIhQRdJ10PRea6sGtEve1yotDXZFCc7S3/1Y8b6Y=;
 b=dc7PJ2FrUehd3Bt8b9ni7TrifgehqnLpQ80hnPedDdAw1nIJ3mOPCSkOqN36HzBp2QVfjAH/Ys85rxp7lwwMTyxqu9sZFFyWFFTgRdXZZn1mJw/K24y0s6q3p4+NdE2/jwg+dqgRbHva2faOrQJSB9x0W5RJ9W87FQz5g2GurQCj829qedEp9QDpLZTM7YMG7OmI2KHfrd5FH8auXGhRu0xeYTi12hRcN4cQV1niUGN8Ui7ba+oV1ucY+aTjxBrBK/Wuv9BkrRnW+4TYHXUj3wQ7dsfAVvtAIo8NM1w+G5Nl1UAmoLf3lGEMh7CiG0GZ4x3nmHWTNDEYGG5+twg4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uejTIhQRdJ10PRea6sGtEve1yotDXZFCc7S3/1Y8b6Y=;
 b=MCXVsPyiNF+zYvFcbNGdP2Zd58lHpbHjCgrwHDV51jq4GKzo3f+mccRxj5CnkgtrXAf9GNfH+MwQIDtTJ1yHoxQLD9lATKq9OBhj3QtsucFzNzSa/2zhxJg2b1OitKP/FCokE5nQNSx1olilwX+1nAgAWuDVFzsCXYrJyUe3M8k=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM4PR21MB3584.namprd21.prod.outlook.com (2603:10b6:8:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Sat, 11 Jun
 2022 17:36:57 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d%6]) with mapi id 15.20.5353.006; Sat, 11 Jun 2022
 17:36:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?iso-8859-1?Q?Florian_M=FCller?= <max06.net@outlook.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WA
Date:   Sat, 11 Jun 2022 17:36:56 +0000
Message-ID: <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
In-Reply-To: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d435031e-a6d4-459d-a017-b4979a3ee24f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-11T17:21:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00f46ead-0a19-4283-1519-08da4bd0fb40
x-ms-traffictypediagnostic: DM4PR21MB3584:EE_
x-microsoft-antispam-prvs: <DM4PR21MB35846FD248C375A2E845BFE0D7A99@DM4PR21MB3584.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIyT08UQvKZQIr+qPLbWfPuIa82RyWxLvxfMiSpg9juG5+P33U/kWlkIk3eqqsxSbLJR7IFms6H6zQiMfBp4AaDJAal7ahn4SVc4td6Xect3fqAaSyfu/deoMC4V9wwQFOdX3KPue5F/TEthRuH7ronXWoCcq3diSdyJoZzH4Qp6VBHZGgVrm9ubgDLUwyrfmBU6wV4wiN/LU9vAwVfv9W3viDjA9SXH41i0uYbJrmoxuUzkMzafpwwO2kJM4hFlS/IQFlMoKcc0goOdJNinqKkoDXXDezuyZr95DNUyOu/BPafAlYZOz54aPUnr5rFsNfD1VdbzM8itHPKUgr9dEljXx8or18QhX7ZfKXNejeV7rEe+XKprm3PJgGrCxPhWz/0LIT/ISOBQQGRwvU6rQDTr7ZIxt6N/K1UNuKjWVRbNzlTHh+RzgHOmxcuzfPDFpvzYoDKQSPFKOvDLMtTADRsmcH/hEFD1FQOG1tC83apHlnEM5x8FlXT2IuIUp7MBbiVkhZx1wBOIw+Jm5E5+Xt9Jm15Las6+pwBiLFD0REr7iVCwVgoVU+4MalZNGWNkqM8a1F3PSUkPqqojXehM4aloolsBswGo6rHEcqhs/HluDeO+xbRxBATJqEZXQZ4L3aKTJ67kQWTsvr6MAmp0uibp88gBMHtQRM1iQ+F8i+uFT+hV/Ov9H/KRpWif9osDTC99sxii2g7xe/1gafIX1ytQzGcuFZyDAAke8BFlgr4wXW5aBuEkrR/1vYUfbIX/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(38100700002)(186003)(66574015)(8990500004)(9686003)(2906002)(6506007)(55016003)(52536014)(33656002)(76116006)(5660300002)(122000001)(86362001)(83380400001)(82960400001)(38070700005)(82950400001)(64756008)(71200400001)(66446008)(66556008)(8676002)(316002)(8936002)(110136005)(26005)(66476007)(508600001)(10290500003)(7696005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+nyuLzEKjmlUsD3+5Qw/XYwLc4qdwsKF2+HfWGEVHWSg7/8cqne4acymRU?=
 =?iso-8859-1?Q?cKgzcQ3rcTntgBYhzgaGPUeLj2wL6pTTLbogS+10nFU2/4x9MnCDnmVqNk?=
 =?iso-8859-1?Q?ZZZ+TFrqn2AixfTiQX5qTmtvh4BeTNTTyLl7uv5JNRpG2dKA4HZExlXqGs?=
 =?iso-8859-1?Q?ZG0sOt7HTUQElO/LI4Auv6eDh8H2Yda/k49OnewyKVGHI+VowPitMnoos+?=
 =?iso-8859-1?Q?leDtxvkkMgEg/QhbP+SGJO1ssjxFk8hZuUZep8M19x3UoyTevMYqnesb1A?=
 =?iso-8859-1?Q?B2echnYRGHmhMHkmjjbYGNU8DaAmkF6CSLaV5sB4Se8J6dIYv7il28yMwo?=
 =?iso-8859-1?Q?k8IcHb1fgCsqgdpwzyjCVpbkv1803rV572Ef4BU78tnvp4wE68a2dQTm7f?=
 =?iso-8859-1?Q?ZYnD+jvoogZ95ZfFYHEc2Q6cCwOTMMqvsmp0HZb3uuo0wXHiAkzWTmyRC2?=
 =?iso-8859-1?Q?SjT6kz/G2kNFFtVTdl/rXOK1FtsejUO1mrv6RRAM74Gc221jo3u8B0q4eW?=
 =?iso-8859-1?Q?0I9JPaFT0pHBY0/W9zfUT8GvGv/Rq8U3dKIiDeGvJlZ/zyWNmDY0ZBHHc3?=
 =?iso-8859-1?Q?LaInhThXbuvMgonor7XbP2JHuYiSCya/b1NvLXNR8GaOChj4iM9Uxc5SzK?=
 =?iso-8859-1?Q?a4Hv9re6sr0XwNsE6LwiETGGoN4WrZ+MN0jXVUJfnEpP+l9ZbBXjJWmdFv?=
 =?iso-8859-1?Q?Qw/hUe5vo7+K0A348MY/F5n+dMKkYvd2cFmFrhKrCMtV9QNOReCejjrrQF?=
 =?iso-8859-1?Q?xsg6//V9JoBCLIvVO1jvp3zErf8ptrXZfpHrnjlwNDlHHDQLDqvnFxO4l2?=
 =?iso-8859-1?Q?vjBYO4W9iAuZ2+b8GZMcQg8LdKSN63pYymTerW4uYS9bMRgJIQaBy4gtyI?=
 =?iso-8859-1?Q?XYEgZVChX48vQEPfJ6sUhUTO2C3xvF3HrjR/A9xd4NXYDoNkywU1nIzPCq?=
 =?iso-8859-1?Q?9tQwn57+KRBvfogiyUrT53f/PHmpp9zNtLAWoRazh/ljR1G9Ul3PI3+jXJ?=
 =?iso-8859-1?Q?lpNf5UQ5b25gc6/s7FGEabdaxAPDQvxJWBLhMJY+tRzdQC8U3zqA3GT2OQ?=
 =?iso-8859-1?Q?TQjleRD0G2K0XWUBa6icdbkVcbJCz4hvB3MnYmlXK+6yZBUdFIvNuv9Gkb?=
 =?iso-8859-1?Q?ZZ+0jdQaAiFlxZVBs6TTzGnlux+fRjPJhqTdgISPFausrrkE1NoPsPtJB4?=
 =?iso-8859-1?Q?eQcSj8cIojNukalEmTzSOGWcnPXcfSIFsop6KznmzKyvGlRg/UnxYoX8s8?=
 =?iso-8859-1?Q?OfciUrf4gUio1Uy4sRTaYpBWoOKBoo7dhIISZOlA0eQlT4Q04tRIt25Ex6?=
 =?iso-8859-1?Q?qlNgnuIU6Ym3FkkCZM4sbpD5PDzaRlT63XdLa+SvT4SmJVFazBbtG2x1K1?=
 =?iso-8859-1?Q?qWT2SI0CSBEwHkukH3WjTUR6uIfv/9R4lljCnqGZtjmLJJ1VnoUMqkSihJ?=
 =?iso-8859-1?Q?XGM49/lhmsdxYiDJbhIgk4gXN1uat0NNTLPBZvqOS6jC6opH/Bo55LEgkh?=
 =?iso-8859-1?Q?sPMk+oGeq73St9BGGZT9WixWc1/5Njzau9+kGTn7D7be2CiQJkusQgEsna?=
 =?iso-8859-1?Q?l3WfHN2panmzqvVp02K1mHqGdAu+pZGvMANRM/Ja57CfLBcWPgnBHhnCse?=
 =?iso-8859-1?Q?n2G1lQH3sCC1jlCfoyJ3VYW5bq495nD2zttddd9ubFeWvwQevVGXxNSPHZ?=
 =?iso-8859-1?Q?bSiBEsSKARzS9qRQ+TszrYK6udpw9qgLNC87LjZuQXggZ5vo4/qzUqbuan?=
 =?iso-8859-1?Q?7Cj94SGrixcZIGzcOrS5LaRToUg8abAfImlbhe02sR8r+DJ9zF0KwOOIEZ?=
 =?iso-8859-1?Q?hquKpk/T2xYfnd/29nv+qsL+fM6dM7c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f46ead-0a19-4283-1519-08da4bd0fb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 17:36:56.6283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZWnmb8qVZm7/bLLLqn/33+XvycyZXPQI5wj50z7oHposRJdJrFjGxMtmHkYkLQV2TjOH5g97lH1p1ui2KX/iMxh5LMRNo0Wl/FSJxL/D/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3584
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Florian M=FCller <max06.net@outlook.com> Sent: Saturday, June 11, 202=
2 8:40 AM
>=20
> Hello there,
>=20
> I'm trying to debug several, probably related issues to your hv_balloon k=
ernel module.
>=20
> All tests are done on Win11 21H2 (22000.675) pro, on a Ryzen 3950x with a=
ctive AMD-
> V, and 64GB of memory.
> An updated Ubuntu Server 20.04 Guest is used for comparison. It's current=
ly running
> kernel 5.13.0-1023-azure, configured with 1GB memory to start, and active=
 ballooning
> between 512MB and 32GB of memory. Memory hot-plugging and -unplugging wor=
ks.
>=20
> Issues showed up when I set up a Kali Linux Guest. I missed the memory co=
nfiguration
> before booting up the instance, so it started with 1GB of memory, and bal=
looning active
> between 512MB and several TB of memory. Hyper-V started to allocate more =
and more
> memory to this guest since the reported memory requirements also increase=
d. The
> guest kernel didn't see any of that allocated memory, as far as I can tel=
l.

Hot-adding new memory is done partially by the hv_balloon driver, but it al=
so
requires user space action.  The user space action is provided by udev rule=
s.  In
your Ubuntu Server 20.04 guest, there's a file /lib/udev/rules.d/40-vm-hota=
dd.rules.
This file contains udev rules for hot-adding memory and CPUs.  You should b=
e able to
copy this file with the udev rules onto your Kali system, and then the memo=
ry
hot-add should work correctly.

I'm not sure why Kali doesn't already have such udev rules.  You might grep=
 through
all the files in /lib/udev/rules.d and if there are any rules for SUBSYSTEM=
=3D=3Dmemory.
Sometimes there are rules present, but commented out.

>=20
> This is clearly reproduceable on at least 2 Hyper-V hosts, with current l=
ive images of
> Debian (Bullseye) and Kali Linux, but not with Ubuntu 20.04 or 22.04.
> (Get the Kali live image, create a new guest (version 10), turn off secur=
e boot and boot
> from that image. It takes 3-5 minutes until the issue is visible in the h=
yper-v console.)
>=20
> After running more tests with different memory settings for ballooning, I=
 am pretty sure:
> - Hyper-V respects the maximum setting for the memory balloon. Although i=
t doesn't
> care if there's enough memory.
> - Guests can't use/see more memory than they had while booting up.
> - Guests can unplug memory.
> - Guests can hotplug previously unplugged memory up to their starting amo=
unt.

Yes, adding this memory is done via the ballooning mechanism, and does not
require user space participation.   The hot-add mechanism is different from
ballooning, even though both are packaging in the hv_balloon driver.  Hot-a=
dd
is required only when adding memory that was not present when the VM first
booted, and that's when user space participation is needed via the udev rul=
e.

> - The reported values seem to be off: After compiling a kernel on Kali (a=
nd cooling
> down), the guest kernel shows a total of 3207MB memory, with 294MB used, =
137MB
> free, 2775MB buffers/caches and 2611MB available. Hyper-V reports 4905MB =
required
> and 5840MB allocated.
> - As of kernel 5.17.11, the issue is not solved.
>=20
> To sum up: I could use memory ballooning if I set the initial memory size=
 to the
> maximum size and wait until it got freed up.
>=20
> There are several reports out there about what looks like a memory leak, =
without a
> solution.

Could you point me at those reports?  I'm not familiar with them.

Michael

>=20
> I'm currently comparing the kernel built by canonical with the kali kerne=
l, but as I am not
> really a developer, I'm not sure if I could even find the difference if t=
here is one. So, I'm
> calling (and hoping) for help, and offering any support when it comes to =
testing. I can
> apply patches, build kernel packages and read logs if that helps.
>=20
> Thx-a-lot!
> Flo
