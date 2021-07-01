Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA1F3B98A1
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jul 2021 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhGAWnm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 18:43:42 -0400
Received: from mail-bn7nam10on2116.outbound.protection.outlook.com ([40.107.92.116]:3168
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232637AbhGAWnl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 18:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuFzV2zncQppsOB/tstT2uAemMjJ1h9huvpOdRDCgHV/ECd9LDnW3uoekLmVPHQk6jM1sdGl/MWF6EhslxnFUxwHm35DHxYLfE3LVGa9ZH3Z3GTlAQF7wpQ2T3UL+O2XPli/ExIphOWyw29q80tO9GacUcoWK9ZTBCTcfQFD8bDpSaSgBbbWpH2v4rKc2K2bTad0V/fX9ZbN5CybrpGJN2a3XD7wWXBxRAlmu4DkW3nR1/jJvDahkCWk/fWhFdQrvC+TkjWpRmGqntNtHiZhhSK2nzBfA3r1WYtZBxRrAK6Fdac0n+U9keHnoZ7GWsvJvuzb644aTNHmZoBzyPTXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip6H4+GKtIobjVqijMLU5EVn/WcydCM4ajnIL8F6zck=;
 b=IJC+N3FuRsxuBdhKA3N3XnMaYt2ClQiFaQNgnwpmyfx71QVQhmds8nEmIDU4JC7wXTpoprql4fLmvAECISQlRh21xdnl070ZoHIOENUm2RqENQCXH6kJVQ09diLtW6fwjlekuxzPQCaE1Ya13mli3CBqGxg01hg2ZfRhRnq+wIGrE9CnYU5J07DmuoHsdB4bLhq9M6iZV8VlTaS2YgztSrSBX2yQYR53gKT3dVj7rwTsssNAsCbLpp44dcL6oMVOqJyfsBN46Yph/pLB8hNF4ss7brFcs+WpFJdJnLDyXfgavsXDwh/BrLnaZ1pYyagAgRxpdfZoszkLP83WP7TEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip6H4+GKtIobjVqijMLU5EVn/WcydCM4ajnIL8F6zck=;
 b=h4aVrP5J8RIFw6Ro7RphevG5qtqFFZMnDKMXGAlkDVESou68MMJhp0lUfVSrx0n5EuxEop3HH7ZQuC+o0/xY364SrdjaYaBejBGpZdD6ObJrFB2gdJIQBQicC6ycq75WtZxqtd84RjU0AOYHv/Wm8KaJ5ya/SxbJpUFFoeXu4r0=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.6; Thu, 1 Jul
 2021 22:41:07 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3%5]) with mapi id 15.20.4308.007; Thu, 1 Jul 2021
 22:41:07 +0000
From:   Long Li <longli@microsoft.com>
To:     Joe Perches <joe@perches.com>, Jiri Slaby <jirislaby@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basqsOKAgAMHtBCAAIrAgIAAfCEA
Date:   Thu, 1 Jul 2021 22:41:07 +0000
Message-ID: <BY5PR21MB15069F0532A1580C75CCF898CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
         <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
         <f5155516-4054-459a-c23c-a787fa429e5e@kernel.org>
         <BY5PR21MB15062914C8301F2EF9C24F15CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
 <59794f7f5a481e670a2490017649a872a8639be2.camel@perches.com>
In-Reply-To: <59794f7f5a481e670a2490017649a872a8639be2.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd7eaf91-f24b-4d4e-aee6-ee27ed525d65;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-01T22:40:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7a01256-7461-44b9-187a-08d93ce15119
x-ms-traffictypediagnostic: BY5PR21MB1443:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB14431C6D44B3F08E4EEB266FCE009@BY5PR21MB1443.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38EQGgulssjNINM/0YF6HSH/QAl+qqfUt7Q6eVOACJ5amRHWW8CjVpxeUUjgzhGyCUvB3iZ6U7vfdgVO9b/9Kkh7HsIHkxoh4K4fN3E9MDVcrRL8aqh582ZJhF7II1dlBAYIooixHRHYXYkcKch3Ldec7Fw4cQHEcKHlx0vW1UW2S96K+wjj4xMs1typnJGtseOLA2nA2D5NY5Xr3Tiq7dJhoBPIOSpMNicsmP/axXveOQJ+HBozbYjgRxbjKLhclLcBxagWIESm1qXpP1VbYbejCt1CVgNpKh6S/pkCQufFsPVZP8g2XtKRkJ5VRgoZJMzjcf2Ye+dABIuPE2+MgOUqr0rl53GaKERUWWMENb7Sz32bD9/aCwvR3ObhbdMBmg+cRI/VFjYWgWaga6k6I9cjhADbAuzL6j8BcVCx4i1aGa6ivdyWbiCQNCjbs4v2uZ1itt83q0oC2nQPOuA9b7yxk8LN+P08Drm5HC6vN/f3stHcEs3VN+Y0Xtw1EQG5OIEFJ9SC2iNP2OokZlHLG3mhYjHNaNJhAGyuOedcjlRsTuahL355q9YN0AczCIOrmwAigZHeyQ1mg2ll68yWIZFSXpbEAg/D/v9cSClW+5iU1dc0Fh6s7VjnaZC46bUeAneL2VjZcm4dBd4lElWBQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(26005)(9686003)(5660300002)(478600001)(110136005)(82950400001)(122000001)(38100700002)(8936002)(54906003)(10290500003)(316002)(186003)(55016002)(76116006)(52536014)(2906002)(86362001)(6506007)(33656002)(8676002)(66556008)(71200400001)(7696005)(66446008)(8990500004)(66946007)(83380400001)(66476007)(4326008)(82960400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xFr//D50Ov0wksf7dnxCm6hoBqI0YCzLpEyX4KJCTrHcNSvAZyfWavanfIgK?=
 =?us-ascii?Q?WPWi5zKG5U5HdgXmBtzp5XT43NxDQrcs1NVl4cFVNRDuatdjTw29yOUHGtY7?=
 =?us-ascii?Q?U4Iy3O+Wv1far/fOA4IucEnfsSIlM+1HKzKLNzXKTX3pqTlQvxGmcfh/zeBK?=
 =?us-ascii?Q?xx7YceveEgdS1KFTCZGhfUGG18CY/cLIxDnc+FwpU2Q5rIWCd2XGM7nCPEB1?=
 =?us-ascii?Q?kup3jHr2uw3MAdelbGVzitO/gr/4kW0/hYw8mCUz1DvTiyQS+q1SRMnL0oDO?=
 =?us-ascii?Q?yg2kn7SJJ+ILcxRzY+EC53Ga+KRFHaUbK8aqnGJpW/56kqPararhH/wovx5h?=
 =?us-ascii?Q?/n8xZxlc6JOEG53j7K+94q0gOUSm+SUtF8+Tet2cLpBgc9z0uB+1semIzxyI?=
 =?us-ascii?Q?REmbHUiF8iRuckMZadBXTGNxD9qpW9txWoNpmRNhzvyXQS2whezf9UXiJyB4?=
 =?us-ascii?Q?mf22i28HLzBTR38cV/YIYgnwyjdKn7KljO9i9n0RIZsC+vJSZbkt+WswAgKi?=
 =?us-ascii?Q?DVP/VkxBMQqwG/t77MAGNMnjKwHbPgHlhrnNv2jkAcydUI+bzJ8AKaRP3NtO?=
 =?us-ascii?Q?0KjDMYtL4l5bQIUS4kV0fjN1vxqf6g3G9pwXtr5DN+w3Lh5uhSuS/FZB4cLT?=
 =?us-ascii?Q?L63fD6XKQukxHNmlA08RYKWioVSnsU5jSXiiEv4SZhEUz7asSdsyjQ1FCuPa?=
 =?us-ascii?Q?F18uRifp7b2d9KINKwtY39S8LGSgia3KT4+UHPU/D5oC+OQyaOT7hSRvYcQX?=
 =?us-ascii?Q?IRPp2u4aSQ4d26ELSjlf6T4qq+YJXM5T4a/nPjqPPCR9jG245rbWwJOKvVzI?=
 =?us-ascii?Q?lDAxJ9SgxCIcplKwkqg2k+CfG6N7FiPYPVArSUNVp+F37UqkX3gZUcMef+A/?=
 =?us-ascii?Q?l1GAe+I4ZohqAUegpxnMSgSHNZC7uaoTsE/jitCpvTeFTEbba9cRfc0Wcy7B?=
 =?us-ascii?Q?XM5VcFl76DjXESR81REFKXKFYrrjtSt9M3KrwP0Fqz7UnQ/+LHBJHh93Kchs?=
 =?us-ascii?Q?oM7kk2P2uJ5TdisbiztaZIAGGuOQ63i7pE+l0747Q2qn8TCnxDZBPliZtnmj?=
 =?us-ascii?Q?ASYU3UzphnP2BFYjmciP/svP2HLFCnk3awZkJicfsutCaBYqBDDRh9VxA23b?=
 =?us-ascii?Q?igzayMOMVaKPjASLK6As+v40fbMOZuZLPt9KtKgwHjVad6eu/S0ARWPpYKi8?=
 =?us-ascii?Q?LR9Czz09zNGGwtFYeo/fJ2jPsrtmFj3HRGnoioXjcsPMtZrit3qf5BlKN62j?=
 =?us-ascii?Q?UPrazfANkhbW+RJOl3q3tbT7pDZlmdCa3nB0lNZMC5soLeI939+kdgKio4Ks?=
 =?us-ascii?Q?F4G2tIOhqbbRImfowkaesGSN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a01256-7461-44b9-187a-08d93ce15119
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 22:41:07.3920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +G5eFTGP2ssQxN6RdYe//GQZFJhCV1nqO4xAqjbLEDeJlUF3dx+tPtR+gvn4ZANaxRyQUuDF4V08+NZwd74+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1443
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Thu, 2021-07-01 at 07:09 +0000, Long Li wrote:
> > > On 26. 06. 21, 8:30, longli@linuxonhyperv.com wrote:
>=20
> > > Have you fed this patch through checkpatch?
> >
> > Yes, it didn't throw out any errors.
>=20
> Several warnings and checks though.
>=20
> $ ./scripts/checkpatch.pl 2.patch --strict --terse

Thanks for the pointer. I didn't check with "--strict".

Will fix this.

> 2.patch:68: WARNING: Possible unwrapped commit description (prefer a
> maximum 75 chars per line)
> 2.patch:148: WARNING: added, moved or deleted file(s), does MAINTAINERS
> need updating?
> 2.patch:173: CHECK: spinlock_t definition without comment
> 2.patch:220: CHECK: spinlock_t definition without comment
> 2.patch:250: CHECK: Alignment should match open parenthesis
> 2.patch:255: CHECK: Alignment should match open parenthesis
> 2.patch:257: CHECK: Macro argument 'level' may be better as '(level)' to =
avoid
> precedence issues
> 2.patch:280: CHECK: Alignment should match open parenthesis
> 2.patch:283: CHECK: No space is necessary after a cast
> 2.patch:287: WARNING: quoted string split across lines
> 2.patch:296: CHECK: Blank lines aren't necessary before a close brace '}'
> 2.patch:303: CHECK: Please don't use multiple blank lines
> 2.patch:308: CHECK: Please don't use multiple blank lines
> 2.patch:331: CHECK: Alignment should match open parenthesis
> 2.patch:348: CHECK: Alignment should match open parenthesis
> 2.patch:362: CHECK: Alignment should match open parenthesis
> 2.patch:371: CHECK: Alignment should match open parenthesis
> 2.patch:381: CHECK: Alignment should match open parenthesis
> 2.patch:404: CHECK: No space is necessary after a cast
> 2.patch:426: WARNING: quoted string split across lines
> 2.patch:437: WARNING: quoted string split across lines
> 2.patch:438: WARNING: quoted string split across lines
> 2.patch:458: CHECK: No space is necessary after a cast
> 2.patch:459: CHECK: Alignment should match open parenthesis
> 2.patch:464: CHECK: No space is necessary after a cast
> 2.patch:465: CHECK: Alignment should match open parenthesis
> 2.patch:472: CHECK: Alignment should match open parenthesis
> 2.patch:472: CHECK: No space is necessary after a cast
> 2.patch:482: CHECK: Alignment should match open parenthesis
> 2.patch:506: CHECK: Alignment should match open parenthesis
> 2.patch:513: CHECK: Alignment should match open parenthesis
> 2.patch:519: CHECK: Alignment should match open parenthesis
> 2.patch:535: CHECK: Alignment should match open parenthesis
> 2.patch:537: WARNING: quoted string split across lines
> 2.patch:538: WARNING: quoted string split across lines
> 2.patch:539: WARNING: quoted string split across lines
> 2.patch:549: CHECK: Alignment should match open parenthesis
> 2.patch:549: CHECK: No space is necessary after a cast
> 2.patch:565: CHECK: Alignment should match open parenthesis
> 2.patch:574: CHECK: Alignment should match open parenthesis
> 2.patch:595: CHECK: Alignment should match open parenthesis
> 2.patch:634: WARNING: quoted string split across lines
> 2.patch:639: CHECK: Alignment should match open parenthesis
> 2.patch:643: CHECK: Alignment should match open parenthesis
> 2.patch:646: CHECK: Alignment should match open parenthesis
> 2.patch:648: CHECK: Alignment should match open parenthesis
> 2.patch:650: CHECK: Alignment should match open parenthesis
> 2.patch:694: CHECK: braces {} should be used on all arms of this statemen=
t
> 2.patch:696: CHECK: Alignment should match open parenthesis
> 2.patch:703: CHECK: Unbalanced braces around else statement
> 2.patch:724: CHECK: Alignment should match open parenthesis
> 2.patch:744: CHECK: Alignment should match open parenthesis
> total: 0 errors, 10 warnings, 42 checks, 749 lines checked
>=20

