Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA68B311482
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Feb 2021 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBEWHQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Feb 2021 17:07:16 -0500
Received: from mail-mw2nam10on2136.outbound.protection.outlook.com ([40.107.94.136]:31456
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232437AbhBEOww (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJuTM8RqXAlNYXb1USiSfbxNmAYrOJjXiPbJdujt3I9oKwu46IeJ2Xir4ileOz9QPVSqYUcpTNTnbUIZ6Uk8eeu0YK4OnWZ2ap2UfsyZu+W/587m9Ejs3ndC52jbuUpVIgfNcgQGXuXfutZWlCWJSgUAEBKYprKTQ2/Cm1ZODliTyDPOLcgSgQM6q54Z/6nJWgnLsZQYJqO+eRqzbtBxxBsGqAGmImo7GD/Z+W2QImXovFQkrQ3aMkPdjeaW05xFbejNFakcQSYjuOHyGgN2/A59Ids1u0A2roxrTZ5YkrpVDomAgwS3uYpgUIrfwPJROJapMpfFSD6Mdw/9miRJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDgU8eSttBcDwICX2B+gomwjkfzgJIaFCBfj2k86xjI=;
 b=dC/sgdXv7on0axrzVqrEjZ5SL/L0JBBIkAkmQ4L7NHpzWdkoKWwiC7j5gQFKZc1Q0kJq7CYqppMRjf00lwqCGz3n80q5/0p6IvVSgA5ynFH0OxnZySsf0Z0/LEp8blWgN3an/SjNam6FgDVfxoItt3xEaj4lpRdE6zhzl7ii2phDCXWGk7BWDPUwsEobRKbLEP6kScoFtDogREdQBuZlw3F/LgEwT9wqJ8a+OQC9nwJTH0Q0R6qNYYYUqdZe5BMVoTOfqOKDi3iIbTKqQsPtIzq9Hdug+dDj5NcwHQngI1p4LHvpkBBCBovPWHAQBqiR0FIdGxoe7bdbe9CJa/uSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDgU8eSttBcDwICX2B+gomwjkfzgJIaFCBfj2k86xjI=;
 b=R3x746QijMyysXuCENUxYwZS/Pz9/FGksasmE/a+xPPWdYpmGJ8fwugU3cimLD0jpAyDB61x+ycSq3NAeyib8KXkax+nHgGL7gyKg6q7EpEgIkNjxUxq5r9xcCfRPJ6XgsqJ9OwcUiWVTRAOUVU8GSjV9WI6NdPF7OLB+lvheMc=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Fri, 5 Feb 2021 14:56:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Fri, 5 Feb 2021
 14:56:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Index: Adbkgi7u1VztxegUSBO0uPzYUvP03gWw0bwwACJGkKA=
Date:   Fri, 5 Feb 2021 14:56:36 +0000
Message-ID: <MWHPR21MB15937CBA4514849A40D53FAED7B29@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880CA1C933184498DF1F595C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <MWHPR21MB159313CE5C5ACEC4F94D8090D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB159313CE5C5ACEC4F94D8090D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T23:35:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=03e0cf99-fbde-437d-a81b-3887d9699748;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a12e838-3c25-474a-1579-08d8c9e63c9f
x-ms-traffictypediagnostic: MWHPR21MB1546:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB1546AD997B06249C17D3AB84D7B29@MWHPR21MB1546.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GS3tPu+25CqbpNmAtbpiKiUkjcdN8a4RIwfzL2lYJKqjv9h907P61Sv1hcsPMMFx30eNwq9waOgzZk+KDTgQjB4rSqbb//3A6FM4n3CsSXOQA4kgXXKQhZwa8FF4j0rLdM1yuQFw9a9ZMu5waZRNcJlc/K7xNDXHpxmBw07bvfE/lAILBWDXk8+NqR1pdzMZ3MyTEN3PZusXfMLofUOv2kSlIaXkH9lxS3y8ylv8kIea70rRmZb6LvF8tYaBTjuwdoP38qmwBpNRsUS97KYmXqh1IjXH8fCiewJ+uCbkpJsj8EccGTV7JdEFbw0odXwCrnBHroZZqM2z9Yp8zjjWv47wT2ePOTJ9FBYCj6hW9iY6PZDdUA/zqbcMXqwKI5n02XGcPH/hcoEto/HgOUAWG2dZyRj/rVTTmKyatALy8HXybjb+kvN6I3+cINhGFSsAMqeCGPnhFOx5FHcrwW4JbpvdAOymYX6BJznt6ofaACqIIOggRNgFmSIKtNxUE8Zx08SJYtjzB+AabG3xxsfH3n14VJ4snmhGDUPeD43sSoeF6QRLcMLkMs2d1w7NQX8U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(7696005)(52536014)(66476007)(82960400001)(8990500004)(71200400001)(83380400001)(82950400001)(4326008)(76116006)(2906002)(66556008)(26005)(5660300002)(186003)(316002)(55016002)(66946007)(9686003)(8676002)(64756008)(6506007)(8936002)(478600001)(33656002)(86362001)(66446008)(110136005)(54906003)(10290500003)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kfaX11yQoy0F/O1K4Pvb/OV2KvGoselz3gD8BnXn5PkycGffkNM1WSDXCHXC?=
 =?us-ascii?Q?fnzOjK2SUqYkwWkcftQqWgBAtIsnYqHVPGGjTLyuDy0me7YLwA30biGYugZZ?=
 =?us-ascii?Q?8nvk+w96gfMLxyVe0+x0Nz4/n6Ko5LR2Uj/9FvfulsRwLsZB8UYF68JjsLZ4?=
 =?us-ascii?Q?uAI9a00wxSrHSCvttiOAM5SuvBRKvzABeW5UGwJBNla0PL5ff8A/eLyHFZJK?=
 =?us-ascii?Q?y6vTIImti0McWqV2kyYtAjx1drmUoaZqGKKK6CmM5bZvWbUgFTYgzCie3LxT?=
 =?us-ascii?Q?X/ZOQ0hQ7S4YSXnmC3dcd8KtlBepuxsKmtDE/UEvoFZyvs3DPxhJgxpkzdb5?=
 =?us-ascii?Q?nYLo5CluOh7dkMmiBGIGfPvgsJNhVUVYdPQP9lrDQ7sVxkSYqKj8OyIsZfbv?=
 =?us-ascii?Q?Du2m4dGA+01sVvxjTugytI3io37k1ovLzEpNOO/PGMuEovozt+ZOoETg0CxO?=
 =?us-ascii?Q?Gl1Ntu4jpajPo9hlIbjMXOheBZ79mIpDKgf+gbHwAgVULUN1Y3CK9kIR29kD?=
 =?us-ascii?Q?O0zJHttn3eg9yRUpbC06kDzCbkmvd8ZZ7+i5PJNl6fi/pGpaK1rEncLAmOgl?=
 =?us-ascii?Q?Cb27umbz8iUvCsgmbGOXEtbzDBiZrm8+CilMns1qycMnr88YUpMnbohkYp2f?=
 =?us-ascii?Q?bm12gJQ6om9J4a5ixstHL/JXFCHPtOYNTp0759HxHoJg421PZuAk7lBFVF0k?=
 =?us-ascii?Q?7bmg05a1LRG3DFOLDhZUKpaQ8S2poWr9RW1CjSuOyiidrH7qpmMC68C3H1mW?=
 =?us-ascii?Q?JV4swF+efEsz0Qj3AEm5t0v6B0+xd5f4X6n8Er9peuo6dVAFgB17VpqTjpVu?=
 =?us-ascii?Q?bqiSST7Bu1kFi377qwrR5nuSqSjeIztuAEGx2qklZUWlAh6zZFEGhyiw1bwW?=
 =?us-ascii?Q?UVaN6g0IiikG5Xaj2A9qbBg5A6rqICJZfj+tY3DSdHKGwGjCma6ThVcW7bzi?=
 =?us-ascii?Q?KI0FXqmIn21Fj5DwGzspgiHzK/6dO5Rk8E8ivar4ubnE86eCIEGgkIinuXyZ?=
 =?us-ascii?Q?LsRDxMCtt+bhBX/EKyyIR0+1hd41BNCiSkJQ+IUquuYmO1FN8lkqLcuCYyH8?=
 =?us-ascii?Q?tzt3uSdUneeQKTgIaeqrSY+ZmOPFq8EPZjQojxiAAQVzcCRzOmSi2acsLD4m?=
 =?us-ascii?Q?QmAgXd6s65IH8thEHJkH9Dj2ENkEQBmyP6BmqguuHVB8QE6OxOT7oWQXcdQ/?=
 =?us-ascii?Q?Pg+7Re2o5Puqdml0808WusL/R8gRqKsrEfbJRILiNZtkgr4rwe5spA022V39?=
 =?us-ascii?Q?hSod3viCKqHv/pfegZqUC4oB4la2y5QQ1hC1giGKt9Unbgxs8DfvKe+RP1E5?=
 =?us-ascii?Q?sklaI/30klnMXFzEFaA6PA+X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a12e838-3c25-474a-1579-08d8c9e63c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 14:56:36.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLq0ItSON0/tW2BLDXDXkM3CtviL2uDmnb7HpYLKjsyeLTsroRgCvYFk+inFfRLsRUXHnyPurUHSyPaXwEaEQ9nZhmeY+XPsnRPh9YmvwAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1546
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com> Sent: Thursday, February 4, 2=
021 3:36 PM
>=20
> From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Wednesday, January =
6, 2021
> 3:21 PM
> >
> > Linux has support for free page reporting now (36e66c554b5c) for
> > virtualized environment. On Hyper-V when virtually backed VMs are
> > configured, Hyper-V will advertise cold memory discard capability,
> > when supported. This patch adds the support to hook into the free
> > page reporting infrastructure and leverage the Hyper-V cold memory
> > discard hint hypercall to report/free these pages back to the host.
> >
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Tested-by: Matheus Castello <matheus@castello.eng.br>
> > ---
> > In V2:
> > - Addressed feedback comments
> > - Added page reporting config option tied to hyper-v balloon config
> >
> > In V3:
> > - Addressed feedback from Vitaly
> > ---
> >  arch/x86/hyperv/hv_init.c         | 31 +++++++++++
> >  arch/x86/kernel/cpu/mshyperv.c    |  6 +-
> >  drivers/hv/Kconfig                |  1 +
> >  drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
> >  include/asm-generic/hyperv-tlfs.h | 32 ++++++++++-
> >  include/asm-generic/mshyperv.h    |  2 +
> >  6 files changed, 162 insertions(+), 3 deletions(-)
> >

[snip]

> > +
> > +	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MEMORY_HINT_MAX_GPA_PAGE_RA=
NGES);
> > +	dm_device.pr_dev_info.report =3D hv_free_page_report;
> > +	ret =3D page_reporting_register(&dm_device.pr_dev_info);
> > +	if (ret < 0) {
> > +		dm_device.pr_dev_info.report =3D NULL;
> > +		pr_err("Failed to enable cold memory discard: %d\n", ret);
> > +	} else {
> > +		pr_info("Cold memory discard hint enabled\n");
> > +	}
>=20
> Should the above two messages be prefixed with "Hyper-V: "?

Ignore the above comment.  The lines will get prefixed with
"hv_balloon:", which is fine.

Michael
