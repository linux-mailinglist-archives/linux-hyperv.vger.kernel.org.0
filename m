Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5A78B9DA
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 23:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjH1VAl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 17:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjH1VAL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 17:00:11 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C10129;
        Mon, 28 Aug 2023 14:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxNuzBpO3QSk5BEMc7Bc/uuSbTtlB0HpkVi5tJRZHO35+6K75+EWsMY3Ltr41/Pw/whhdJJN4azuuAxlHIY8Dr/WNOrtjxt8Pvr/BoDzBHMUC/KAJ+KIk3YRClrhSmfFNHbOwm8POpfLJrE1mGeQ3kEeuH1rbgzJWlNc/PAr9NTcKgzOkwnTEPS4YLkMzZHdpsKvabHx/vp2T57TyeuELbjuIm1GGFbEbbp0VQqRrcpyQpbKo/R2H9ph4bH3xKq+/aY47JfBVLQqdvL9CQOu9M62WbK+zYkgSmkbyDfSc6w/wDIjexI8AzU37G5gFB05oum+Jdll+UTPaqOBMtFT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKwniUwAVVtvJTjgQTBxaQenhSVDYvgiEVGx6WJeyUA=;
 b=IHYH1r1EKiXgPX5HSUI+q390YTmAD5sh2mUWdcZrWiKcTrC3eYAyMQGXtUzlVuY0FSzezckYKCsUOk44gewS7ZoIco00sfo/IocN8KtTrf2rx0D9YrZP8u3Vx4Z+lhx4zWUzqvWoOeIMX4qUQQKTZxs3rvQ0XSTQiGxKRNZBok7FFjFaZN+CR2ciG4lTDx0awhlpNzZBdwMAX3JTD3O+Ab2nIqm5AOeoy9tDuPKLVRPXNppVwizCqATsiQZAG4npS5OQYTZ08a5QWRLUrF8GJedDrVoZR5Ql9TINyoiLVChvVThPop20TFL6lRDCVb0BokP/0DfdSsY9bcbGimpg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKwniUwAVVtvJTjgQTBxaQenhSVDYvgiEVGx6WJeyUA=;
 b=ieelOc6uBrtwMtAlzJ92//4Pyu1vhCbp/0epMTGZvibZ5vGLezu7ML9iKsfk1EypTO/K2WD2JIa6x90aMRh7yAr+dohKLzGPYCXT4Y2NAn/k0yIj3JIBA5U0eDS/M45SOUk4xiptAUxsIOsYppcIF3q757O2L+ZCspSzBhT8jng=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3381.namprd21.prod.outlook.com (2603:10b6:510:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.6; Mon, 28 Aug
 2023 21:00:03 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%5]) with mapi id 15.20.6768.007; Mon, 28 Aug 2023
 21:00:03 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj16DTf9qLclEez7by16vQ1nq/eB+iAgA5qfICAEu+xIIAA0qUAgABNx5A=
Date:   Mon, 28 Aug 2023 21:00:03 +0000
Message-ID: <BYAPR21MB16881D49DF82B0432CDFBA44D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
 <BYAPR21MB16887FF9CC6DFA6323D10464D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB16884D7E004A4544F3EA6314D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230828161304.dolvx6bgnxrqilmj@box.shutemov.name>
In-Reply-To: <20230828161304.dolvx6bgnxrqilmj@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=96d182e2-7e95-42af-b3cb-7b8da689235c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-28T20:51:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3381:EE_
x-ms-office365-filtering-correlation-id: 9e98dd9e-7046-4e95-8287-08dba809c044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IB5vQuyJfjM6QutK2h/V77furEXOIL588si8IbIV3T9umF3Rdx7fkr2M0LGqHpBNkebsX2tPVs/gjjuZWEtYbxoQ1pG1PJBl2RnkqwMAU0uUTjxEbItrlCVuHqgAYUR9F//ewT7578gIxydmiYYrA3Buz17FeIYTis6ZOilg+r6UYB4wC/hUgcfsWCC+xmNGL70id8wMk5noXnu9y+Ilhe+8QzBhkMfP2ofpLCZv75fNbxKFHrM/1Q4oQStqvujXT06gjup5XR3RFcrSbJkpQCk9o/KQfhDZ+CPwtzFHlyLZFFG6HdEaXu6/ULp9ev87WalgczHMBUTTF0ZbEb5EtywtnOaGSzDhCrgCiLqbhAOGdur0fR05VMRk0FHoRgUC/nvYZr1zw0eAe59v8FPG2qTj2eqtEEbMoE6u6gW58SUUwShSE4pbZjSDxBpIN1PSPny3FIHgjYvU5e3HCou+9ZdXMzSh64N6OsAWM/sT3oDLtcvyY8L3oXKNFNJbl1kO7rh7iCXG41dAe6xh0Wh20Ve4uNlbG1OYSQTP0K/wN9tvZ1Kxpsxj/QEnhNUNvWPjPMCpIAUe696lqtpBtSehNMzsjL+q+ZbqKJx8DOgi/5bzFOezzmTv7AtDQm0Spw4bws7yK+PU4W2I0ved0twY8fh03S1seyS6d89GZlK9TK3RxOEa9fUqloo/36TuWScmC91LxQBZhP2fq8otiZ7kBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(136003)(39860400002)(366004)(396003)(376002)(186009)(1800799009)(451199024)(41300700001)(82950400001)(38070700005)(38100700002)(122000001)(86362001)(10290500003)(82960400001)(478600001)(83380400001)(71200400001)(8990500004)(26005)(9686003)(7696005)(6506007)(55016003)(66946007)(76116006)(66446008)(2906002)(33656002)(316002)(6916009)(66556008)(64756008)(54906003)(66476007)(8676002)(4326008)(8936002)(7416002)(5660300002)(52536014)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?92TMEJhpmmqsVS0MW+PTvbZhFZO82NkB/jL4VFgQOS/BV0VPUQGSAK1sCr/U?=
 =?us-ascii?Q?ogW1B0+8Z1G2+u8z/q9EOq9B7r6IipQvDNy92ndU+WrwlvffPfk8x1F/DmPp?=
 =?us-ascii?Q?IkCzYrvV7h1NvMJuowRQeKmENd8xHkUOmm6CwAUnp+FtZYVyen0aaL3RP5J1?=
 =?us-ascii?Q?VtkM93spMwd45wSnLPFht3+OGEaaBIyV0mdyh08YaPbvMb8GpvjMoCLnmpbh?=
 =?us-ascii?Q?mWkLeMomDbs6pgq0jx1v/ykVgkxgkhzdW92bEhXsYnSDljuO/2qCmSSresJV?=
 =?us-ascii?Q?GBFargxrJvuqr5bYLQ9aqtZVtT81r2ZHepjPbe/RqQI8+ybB3G1XBAUMrX+Z?=
 =?us-ascii?Q?LRplQnB9Nwrg0PLH3kGPxSVPpnPmq+3TTmz1TozZkJSbhD4SzGJSc6C9XhCV?=
 =?us-ascii?Q?A74L8M9JfbdAP9sW9Yx6WQjL4SQ6nDdTdyw4GhRpQ58EwwM91WUMH7ook4L0?=
 =?us-ascii?Q?tvZOSPUWXx8sti4QGlEIkK7jPcV0qWe4wWiDv+Cew+Fn7Zi1lAwdYX0zaoAR?=
 =?us-ascii?Q?z39E0XlIh6t9Th3win6sQU+iv1BffHkfEfvCEIoVeOXmRQzLd0sHot+IYlA7?=
 =?us-ascii?Q?H8/LYs7SUpv80ixXErUHRFL26Z3jfvsS/K+RLg0PfxsRdV+vWOBZsyhFUt0I?=
 =?us-ascii?Q?SPhDzgsKi6pl9I6C5Wgc7bXWErfueeM/Qyp/SdBqmanHlSa5PJRM1EHf+T96?=
 =?us-ascii?Q?4RXQllAmCjgt8PPfZZKPzlD3VxL/9i08kr+t1XGu4M4yipRVNS9dd1Js+JSx?=
 =?us-ascii?Q?4u+QMP3/ctc+97oSbawblp1OI3hrOkZ1sfqTY8Rmq8yZhfPLeu9heCfSOxho?=
 =?us-ascii?Q?3Fvkb5EWjgV7Z91FbOqAWJPNvvVdCv8J15S+XTpP84lhIu7dWExI7pBYCVS5?=
 =?us-ascii?Q?FXjIbGpcFNMQKfxAknmFvu7yTdkzULvNd8AyHdM5rDj9QUq8YFB74SS7wDGD?=
 =?us-ascii?Q?ZdyW8jvqcLGNg8zQCgYlXvS0FkE1mI+xKSHpVj30A+YeIc4t2css+y9h01f3?=
 =?us-ascii?Q?O6a58hZZp7ft6oSpcGgYSo/k+BwmIWUbPRjXhGV0yR5g5IsOyhoutDNtPz/r?=
 =?us-ascii?Q?eMt19KZnCjadE348iq5MfE6uwTZy75dmYAIjyF41zAS4rrV0K+Zu38p8zjvC?=
 =?us-ascii?Q?BtxrWeBcxS8vG0ShkBvFBXqYklDWDi4JKDRxnzxFi7/EEGlw6HcHBMv15ghe?=
 =?us-ascii?Q?tOze7k/1c8XgmFsgOLgZHDBg9LaM7sJzh1tVKwNMrIyVcE/9MCahylie4H3V?=
 =?us-ascii?Q?9QQ/MYJ5Rsh7ChrvZawZbTeTrcqbhP2kuwGnlnGivQfrCkQ1psFfnQK09Lh5?=
 =?us-ascii?Q?MguVRqeMdihDOmVCkBQcj5peBMqW9v+yzAcxNVQqdzPFO1DzbOYuG52rhhqa?=
 =?us-ascii?Q?DFNr8YYUxboe4akzDWJ4xJf2YhwK0oPaWB5HdzhAoCqk3NynygGE3hQ1s/d5?=
 =?us-ascii?Q?itCT4jHv9VYCk+Os5D4u8J094ri6TKsFxi5UQD+pXSbD9RZ9e9h1/K+I7NB2?=
 =?us-ascii?Q?0BpeORuagI267hI28okJ8RjybiJ4SyBpqzFxBD2P4cuIhzXqFihRNjbAvqIW?=
 =?us-ascii?Q?kZqo4CN7zwafcCPsLPds3jRWGzumCsJhE2Bdk6wZOPyR8Z/xGSB/paafbkk4?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98dd9e-7046-4e95-8287-08dba809c044
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 21:00:03.6842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuXuCHz2u+RSERS9kkGd8XzygPWoFXHquHMjsu1uSgaPyYr3KPjcy3wytqqyd8ECaf3s5Pf/qsuGBlgJxJ7fram7M0XDc8R6rykskavd4Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3381
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> Sen=
t: Monday, August 28, 2023 9:13 AM
>=20
> On Mon, Aug 28, 2023 at 02:22:11PM +0000, Michael Kelley (LINUX) wrote:
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Tuesday, Au=
gust 15, 2023 7:54 PM
> > >
> > > From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.co=
m> Sent: Sunday,
> > > August 6, 2023 3:20 PM
> > > >
> > > > On Thu, Jul 06, 2023 at 09:41:59AM -0700, Michael Kelley wrote:
> > > > > In a CoCo VM when a page transitions from private to shared, or v=
ice
> > > > > versa, attributes in the PTE must be updated *and* the hypervisor=
 must
> > > > > be notified of the change. Because there are two separate steps, =
there's
> > > > > a window where the settings are inconsistent.  Normally the code =
that
> > > > > initiates the transition (via set_memory_decrypted() or
> > > > > set_memory_encrypted()) ensures that the memory is not being acce=
ssed
> > > > > during a transition, so the window of inconsistency is not a prob=
lem.
> > > > > However, the load_unaligned_zeropad() function can read arbitrary=
 memory
> > > > > pages at arbitrary times, which could access a transitioning page=
 during
> > > > > the window.  In such a case, CoCo VM specific exceptions are take=
n
> > > > > (depending on the CoCo architecture in use).  Current code in tho=
se
> > > > > exception handlers recovers and does "fixup" on the result return=
ed by
> > > > > load_unaligned_zeropad().  Unfortunately, this exception handling=
 and
> > > > > fixup code is tricky and somewhat fragile.  At the moment, it is
> > > > > broken for both TDX and SEV-SNP.
> > > >
> > >
> > > Thanks for looking at this.  I'm finally catching up after being out =
on
> > > vacation for a week.
> > >
> > > > I believe it is not fixed for TDX. Is it still a problem for SEV-SN=
P?
> > >
> > > I presume you meant "now fixed for TDX", which I agree with.  Tom
> > > Lendacky has indicated that there's still a problem with SEV-SNP.   H=
e
> > > could fix that problem, but this approach of marking the pages
> > > invalid obviates the need for Tom's fix.
> > >
> > > >
> > > > > There's also a problem with the current code in paravisor scenari=
os:
> > > > > TDX Partitioning and SEV-SNP in vTOM mode. The exceptions need
> > > > > to be forwarded from the paravisor to the Linux guest, but there
> > > > > are no architectural specs for how to do that.
> > >
> > > The TD Partitioning case (and the similar SEV-SNP vTOM mode case) is
> > > what doesn't have a solution.  To elaborate, with TD Partitioning, #V=
E
> > > is sent to the containing VM, not the main Linux guest VM.  For
> > > everything except an EPT violation, the containing VM can handle
> > > the exception on behalf of the main Linux guest by doing the
> > > appropriate emulation.  But for an EPT violation, the containing
> > > VM can only terminate the guest.  It doesn't have sufficient context
> > > to handle a "valid" #VE with EPT violation generated due to
> > > load_unaligned_zeropad().  My proposed scheme of marking the
> > > pages invalid avoids generating those #VEs and lets TD Partitioning
> > > (and similarly for SEV-SNP vTOM) work as intended with a paravisor.
> > >
> > > > >
> > > > > To avoid these complexities of the CoCo exception handlers, chang=
e
> > > > > the core transition code in __set_memory_enc_pgtable() to do the
> > > > > following:
> > > > >
> > > > > 1.  Remove aliasing mappings
> > > > > 2.  Remove the PRESENT bit from the PTEs of all transitioning pag=
es
> > > > > 3.  Flush the TLB globally
> > > > > 4.  Flush the data cache if needed
> > > > > 5.  Set/clear the encryption attribute as appropriate
> > > > > 6.  Notify the hypervisor of the page status change
> > > > > 7.  Add back the PRESENT bit
> > > >
> > > > Okay, looks safe.
> > > >
> > > > > With this approach, load_unaligned_zeropad() just takes its norma=
l
> > > > > page-fault-based fixup path if it touches a page that is transiti=
oning.
> > > > > As a result, load_unaligned_zeropad() and CoCo VM page transition=
ing
> > > > > are completely decoupled.  CoCo VM page transitions can proceed
> > > > > without needing to handle architecture-specific exceptions and fi=
x
> > > > > things up. This decoupling reduces the complexity due to separate
> > > > > TDX and SEV-SNP fixup paths, and gives more freedom to revise and
> > > > > introduce new capabilities in future versions of the TDX and SEV-=
SNP
> > > > > architectures. Paravisor scenarios work properly without needing
> > > > > to forward exceptions.
> > > > >
> > > > > This approach may make __set_memory_enc_pgtable() slightly slower
> > > > > because of touching the PTEs three times instead of just once. Bu=
t
> > > > > the run time of this function is already dominated by the hyperca=
ll
> > > > > and the need to flush the TLB at least once and maybe twice. In a=
ny
> > > > > case, this function is only used for CoCo VM page transitions, an=
d
> > > > > is already unsuitable for hot paths.
> > > > >
> > > > > The architecture specific callback function for notifying the
> > > > > hypervisor typically must translate guest kernel virtual addresse=
s
> > > > > into guest physical addresses to pass to the hypervisor.  Because
> > > > > the PTEs are invalid at the time of callback, the code for doing =
the
> > > > > translation needs updating.  virt_to_phys() or equivalent continu=
es
> > > > > to work for direct map addresses.  But vmalloc addresses cannot u=
se
> > > > > vmalloc_to_page() because that function requires the leaf PTE to =
be
> > > > > valid. Instead, slow_virt_to_phys() must be used. Both functions
> > > > > manually walk the page table hierarchy, so performance is the sam=
e.
> > > >
> > > > Uhmm.. But why do we expected slow_virt_to_phys() to work on non-pr=
esent
> > > > page table entries? It seems accident for me that it works now. Som=
ebody
> > > > forgot pte_present() check.
> > >
> > > I didn't research the history of slow_virt_to_phys(), but I'll do so.
> > >
> >
> > The history of slow_virt_to_phys() doesn't show any discussion of
> > whether it is expected to work for non-present PTEs.  However, the
> > page table walking is done by lookup_address(), which explicitly
> > *does* work for non-present PTEs.  For example, lookup_address()
> > is used in cpa_flush() to find a PTE.  cpa_flush() then checks to see i=
f
> > the PTE is present.
>=20
> Which is totally fine thing to do. Present bit is the only info you can
> always rely to be valid for non-present PTE.
>=20
> But it is nitpicking on my side. Here you control lifecycle of the PTE, s=
o
> you know that PFN will stay valid for the PTE.
>=20
> I guess the right thing to do is to use lookup_address() and get pfn from
> the PTE with the comment why it is valid.

Each of the three implementations of the enc_status_change_prepare()/
enc_status_change_finish() callbacks needs to translate from vaddr to
pfn, and so would use lookup_address().  For convenience, I would
create a helper function that wraps lookup_address() and returns
a PFN.  This helper function would be very similar to slow_virt_to_phys()
except for removing the shift to create a phys_addr_t from the PFN,
and adding back the offset within the page.  Is that the approach you
had in mind?

Michael
