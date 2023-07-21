Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92875C8F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jul 2023 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGUOFK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jul 2023 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGUOFJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jul 2023 10:05:09 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021023.outbound.protection.outlook.com [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786111BE2;
        Fri, 21 Jul 2023 07:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRDAiy7kZ3P/r03FS/3dm8PfIe+2wr6jFg104yOzpWEZGpTxt3SKw0SjYkvlkKM3487OkkvL514CLO2dHHQnU4MGPTTCdS/4+TCNzraoFx9Qd3NyZ+e30vFV2T+a6d5FnHeINetuOxFNldKi3hJeEaLt8mVPclA+nfvmapp0/+I2TGH+NiowEzbBMnQc/COrrAcbi6dm37DpJxOlkhQQWU7aQtyF789jhkR6BmhYHNli/JgczGA+1jtwRc4phtL/w/qnA0FnS76SwLUmqlDmYi6MQ7rMav5i6lWnNdoW+7vTW63naa+/au7/c///b3Rwjx9MpYORTnMs+2jCBJzwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5ZspRoWDL4NP1n/zoSVzPkthz51DoKre0LACDeASco=;
 b=XUUQMMA49JJqh7rrp3b7Aqr0+2tvQx+d6vHNwUe88WifDf63+iDLqMrjBwrj5l/hLqOU//MSEIjUFf+Qm6ew3iD7/RkRr661zI8pwsu/rwTINvikkmBn36NmxIsYybLZHf1TC5PaCtfztZONaNTEOnmH5VGlLARCJbkB/L4ajHqfrVQGeWm/XqP0lb8baH8K8nK9dRuxsyWLJYxuVz5o2ew3pSA7DKls70pXPM4SCebtvgkfe9yYeKRvqXS3tfHDlDlb4tj6LMSCQOdtP6qnr/OpJylItp2MlH+2fb9z7Rar/seTfRm8bT8mCkAWz1p54Gvo7FOoj0JYLAJL94YTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5ZspRoWDL4NP1n/zoSVzPkthz51DoKre0LACDeASco=;
 b=MJ1dr9nDs1x6kpxex9aIS2mT9hviAvoJVyXB95ah65B6y4zqof2b8uc1H9J2CiIOmY6/LrcktSIu6mmpuKDNuEbMhfOlm6ptl6apK6DvWeJa1sZTI6QsQ5nQznJT4CawxsvolAUr7wsFuw4yBcUY+5zpVDlEVtQdwAizLkOBfp0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1401.namprd21.prod.outlook.com (2603:10b6:5:22d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 14:05:02 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136%4]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 14:05:03 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Topic: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Index: AQHZu0mXUyEtW9eyqkWnVGF605KOSq/DKCeAgAAzncCAAOUgwA==
Date:   Fri, 21 Jul 2023 14:05:03 +0000
Message-ID: <BYAPR21MB16889A4BD21DA1F8357008FFD73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1689885237-32662-1-git-send-email-mikelley@microsoft.com>
 <20230720211553.GA3615208@hirez.programming.kicks-ass.net>
 <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b52301eb-604c-44e1-bf56-29beb984d9b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T00:20:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1401:EE_
x-ms-office365-filtering-correlation-id: 931836d6-fb9e-487b-1c2b-08db89f37b1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ZJKKzfeXplfQJ6MtICO6dJBg/1ovAmMkfHZDvMofli6JG3JDMvNjVJte/98J0ir3ZxHxGtwrHOYMmvhz2AibrqoTcNt0RgsdAuK5IO7aub+Xajg+oUxAM8FLdjr4S2b6GwNsEzUPbPvRCRi7e0HzyDnYsE9gGpi6Z8YqeATloB8mFbHnIj0Wg5CVxZRM/KFZk8C0wN9I4LVPjCJapvD7gHEvbzYcbCMucS/ge98Ae3JimajgDj/EL/a1uueoOUQslj7F6Gv1cXZPGGdvGAFSJQm+/TX8h4erYfsMovIMUJ/5k0CA6Gmjnwclr9Yp5JqDC9ZEDWrfIXPNGjfr4+pE+E1NtpVp0417LtPf4PjK2HmamAOP88c+JUDeNSOxAE8LCfbEaKe/J6DB8VCax6yqjOb1tpW6amYU4AuukCzKS/QGIUCppxD9J1HcadH/1M5tmGwCAFop60i7xm/7peAK/KdAvRhZSXCIJZnJxhCid8qJuv+ur0+oI1uy9mjlK22lmXKI+RSAocxmnpb3UnyFJPzydaX11ETIw0sMeG4AKiumPwyDBjWCA+nyS4RTs9c7uDKEAJ3nqidT45kw/xL9Uu1+wRzZEXxGFC9/PYgAyBa602iBsI7eXpv37ah9jqsaYJ4BS3VzBK1QCz57CHvRf8dka+Xw+TE/zUja1PT0mQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(66476007)(64756008)(66556008)(66946007)(76116006)(4326008)(66446008)(55016003)(38100700002)(122000001)(86362001)(9686003)(26005)(186003)(6506007)(38070700005)(83380400001)(82960400001)(82950400001)(478600001)(71200400001)(33656002)(110136005)(54906003)(10290500003)(7696005)(8990500004)(7416002)(2906002)(5660300002)(8936002)(52536014)(41300700001)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0DKlTgVTNv0Lou0ZzO7w/ZYI27n9NnNv+HOTs9E8VB+rnZ2cascY7aaifoel?=
 =?us-ascii?Q?FmQOJ+6m29b6qh+8JW7YWOle6i/827kfzrmmnBDhLjvmupauv33InFsX8D3m?=
 =?us-ascii?Q?MTE8r1rFigULUCYUBpH/9eSuuy1xE4aFldGPtgpNiufocDg/uxbIeJ/iTnZm?=
 =?us-ascii?Q?l1LlLZP3UqP/vDzkVtm1+bLjDpBVoz9yx5VDrdxvTfxAi5s/2dvSM0L1tGCz?=
 =?us-ascii?Q?be9upJYtQKcww3lKfBQaSE8cFJ8hejUCsUhoXmB9ph6+j+dI/sfsxmzb2wsF?=
 =?us-ascii?Q?tHk6qhV6vQusMpNIGGIzwk1vb9LfKJSQywnRYwWmLGhtp3r4I1pTEUhUt/2X?=
 =?us-ascii?Q?pTtkpUfEkbUfL9OeGnTYcod+CYdLxSlrBM/R5n7P7SLjD0ORl9dyJY+FNcfz?=
 =?us-ascii?Q?+RspKWQwnvz/oQIRLfwhUMPK7iJ5AzaVu+yvkg+5UhIe7KugqGCeUQj95zYj?=
 =?us-ascii?Q?C7daJj9ew9hdQrx/fh2rsX6kmzuOgsOnaiviTjKlNAnBqL00/Rh2AHOSqmBM?=
 =?us-ascii?Q?2mRMvECTncekj+eSP+Nsyx/KUFpTObfNmh7mCfWcyK/bj+/lsWJr4+VitBao?=
 =?us-ascii?Q?FUmZWLVWy/O5bGDLg4F8gLw4xe379oea+jL/nBXaryzADUA+93PRxJU5TrDS?=
 =?us-ascii?Q?LQjjmOc3bnjDYq/xtUiQimeUDzM7LeZb8lsIO/D28TwkuwZJQGOU1IH8Vg+Q?=
 =?us-ascii?Q?RGwbJOY8/WnYwpAFjuHUrE2bXt7+Ze6isrWpFG/FHVlYzGx7WDkFTLyYwenR?=
 =?us-ascii?Q?30WMiSK7cYjZGjTo1HDbbprEiQPk2dDyxShoZEXR7T99ki1vCc3iKu8M2nRS?=
 =?us-ascii?Q?96sBFrsN3KtqePT9EP8fsrz28hm2k4U4zJyWpXqJ+XTN73+9RBKL2Aq4eJ5X?=
 =?us-ascii?Q?wXio5kah4G0FWo4EKFeP+NyV17+czlwSi67wGOOzWnG217P6Sc1bFEr95z0g?=
 =?us-ascii?Q?Ocw5/zImw6cWUnrnaqTh0bHuJFaoT+nAyU6skv/SJEaHHYGHovFZzBlt2zDU?=
 =?us-ascii?Q?/ACbr1xLzk0f7vyTOslNjCF4oofM4eBjuBa51HwP34TGFvHTrBAugYjRz75j?=
 =?us-ascii?Q?GBFwUCk7iW+4LwWJmdffmYoAe6sqOuKCflVgy4BqZc3cjDotjTCTo5iwKwiI?=
 =?us-ascii?Q?exUNR94eNjQFQpGRI87XVfoUTRnaifad6nplpj4RGIk0pP7aO8BLXTP/xmPg?=
 =?us-ascii?Q?mMk1TUkD4+mi1CJOvbJCxQEZ7a/nwuUN6NXn7XTGaHdw7fmeLgEIm8Xb6Pn1?=
 =?us-ascii?Q?NFQPc/tzxTwsbmHNNGa6Mv7tG8ciCN/mOkDunyGYw+SX4BtvcArsb4dClOTF?=
 =?us-ascii?Q?w+v/2YvMVGZDGkKjsOnNy/08acxTlxtdobFsCq/V2oiCIFDoRBs0027x/0TJ?=
 =?us-ascii?Q?LF7wUZaHpBPiA7czcFY4+r1IgHYnECVLBKybBSLxueQxtxU/i64cLqM9NIkD?=
 =?us-ascii?Q?g10dOrCYKswVCiFkBDYsO4wl/ChcjKZCkWDyCBPX5f4Ep4nd0nlRq62vM/m/?=
 =?us-ascii?Q?2DEesWobyF+b0pXJ0U8RhlEbODBECaw4gVqj2TUfJ8sgI1867hKVex/Xhngi?=
 =?us-ascii?Q?1mGnyUs1p7pW/hJITAT/VvhofrXd0AbUXze1EEZysYJ8zw2JxQ6SiZwsMhkn?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931836d6-fb9e-487b-1c2b-08db89f37b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:05:03.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtpUg6UVzvgtbJo+bOYY5YtG4qoHPqRUcorVxdvAuMfvcgh5qCP2obIIX4kgRqFNTvtCqKb1hBYslivuCANYd++WmSf7vTQEwEoi8tj6qs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1401
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Thursday, July =
20, 2023 5:42 PM
>=20
> From: Peter Zijlstra <peterz@infradead.org> Sent: Thursday, July 20, 2023=
 2:16 PM
> >
> > > @@ -472,6 +473,26 @@ void __init hyperv_init(void)
> > >  	}
> > >
> > >  	/*
> > > +	 * Some versions of Hyper-V that provide IBT in guest VMs have a bu=
g
> > > +	 * in that there's no ENDBR64 instruction at the entry to the
> > > +	 * hypercall page. Because hypercalls are invoked via an indirect c=
all
> > > +	 * to the hypercall page, all hypercall attempts fail when IBT is
> > > +	 * enabled, and Linux panics. For such buggy versions, disable IBT.
> > > +	 *
> > > +	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercal=
l
> > > +	 * page, so if future Linux kernel versions enable IBT for 32-bit
> > > +	 * builds, additional hypercall page hackery will be required here
> > > +	 * to provide an ENDBR32.
> > > +	 */
> > > +#ifdef CONFIG_X86_KERNEL_IBT
> > > +	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
> > > +	    *(u32 *)hv_hypercall_pg !=3D gen_endbr()) {
> > > +		setup_clear_cpu_cap(X86_FEATURE_IBT);
> > > +		pr_info("Hyper-V: Disabling IBT because of Hyper-V bug\n");
> > > +	}
> > > +#endif
> >
> > pr_warn() perhaps?
>=20
> I wanted pr_info() so there's an immediate way to check for this
> case in the dmesg output if a user complains about IBT not being
> enabled when he expects it.   In some sense, the message is temporary
> because once the Hyper-V patch is available and users install it,
> the message will go away.  The pipeline for the Hyper-V patch is a
> bit long, so availability is at least several months away.  This Linux
> workaround will be available much faster.  Once it is picked up on
> stable branches, we will avoid the situations like we saw where
> someone upgraded Fedora 38 from a 6.2 to a 6.3 kernel, and the 6.3
> kernel wouldn't boot because it has kernel IBT enabled.
>=20

I realized in the middle of the night that my reply was nonsense. :-(
pr_warn() makes the message visible when pr_info() might not.  I'm
happy to change to pr_warn().

Michael
