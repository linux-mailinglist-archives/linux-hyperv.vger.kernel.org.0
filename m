Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1278BB74
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Aug 2023 01:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjH1XYe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 19:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjH1XYC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 19:24:02 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B92C2;
        Mon, 28 Aug 2023 16:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaK4zxZr+uKI5fYe2DGmvekxqZa8sia87gcssjKlBhB3ai5fLZIMikyYnflgGCTrCyHNNpwq4PPGQs9MreOBjtxQxbbA+bZGhBWk17RuflFnZRryUX3gkkWj8SoqR9P81Mwtn4KUMp1Z/ihYW3pG2oUkudWR2Q6f3vpnn1MuYB8jdVg4GvvgtIoJDjsRo5M4ZtaIWkkY979zCA25vSiasEiCxE8mrqQ77hX43QsDqiqPnUVDelvwMd2AkFSim6+AkYvC5vxdSF7lvzPGM7D2Y2Qmq6371BWO7p5DIQIPraYQKxPrUFKbfovujPwpxkmowFjYRAd/WxtG5/hlDok3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny55XFqBVDKMizYll3OrV5cu1xEFS29plSetP9Niijs=;
 b=ezx4fveh9Ectirh5KGxv2OYMwIHEjAjSS4ghQIZ1Cb2pLbEjEpoQpJ131w4UiaRIRlHNwkj0rfDsp2aHAAmtWt1wzYp+bbAPpVTCG/r45greb8J6l6lpSAIVLS0q60SFEU2H4qO2evPgio6BZMZf8g547MOXbN3ANi3hL0TsLGmU7HZnlehb6L+JvzxLjiso8Qv0IC1ab+XBNuONx/MXOFLMw177RBM1HP8OnhNyeCO7vPjaEy4bPXVTfAnHYexX3L5uf6qraj7Y1DIw1mjABHGnHs7+sGCF3aQIW1ETnIQFxtWgjElSEhDZ7vvc6xLOjMiiBFunE4ISs+DvBo5Fng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny55XFqBVDKMizYll3OrV5cu1xEFS29plSetP9Niijs=;
 b=QeXELRu4laj8sdLQIOlAlN9QcMWil6Twc//olhm4SFzwV61TBPLjtICuiafct01YvUhbRIQKSVMlNHRaSoyVIRa1PyZD2UFmc3AUsKXtfmtt7iRpbBE96ePhMlQDIXtsJBbbIy/oX9/lk0NuL9tRzugEMSNEUl4vnZo0wVoYwM4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ1PR21MB3603.namprd21.prod.outlook.com (2603:10b6:a03:451::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.8; Mon, 28 Aug
 2023 23:23:55 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%5]) with mapi id 15.20.6768.007; Mon, 28 Aug 2023
 23:23:55 +0000
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
Thread-Index: AQHZsCj16DTf9qLclEez7by16vQ1nq/eB+iAgA5qfICAEu+xIIAA0qUAgABNx5CAABbwgIAAEdRw
Date:   Mon, 28 Aug 2023 23:23:55 +0000
Message-ID: <BYAPR21MB16886F58824A36D2FF6428AFD7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
 <BYAPR21MB16887FF9CC6DFA6323D10464D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB16884D7E004A4544F3EA6314D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230828161304.dolvx6bgnxrqilmj@box.shutemov.name>
 <BYAPR21MB16881D49DF82B0432CDFBA44D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230828221333.5blshosyqafbgwlc@box.shutemov.name>
In-Reply-To: <20230828221333.5blshosyqafbgwlc@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d0daef63-8949-4e86-8828-16c2ca082361;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-28T23:17:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ1PR21MB3603:EE_
x-ms-office365-filtering-correlation-id: d7e38d0c-ea93-4edd-a3aa-08dba81dd905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYYQ35hWP1IFwR46yg6BFzRXzsJAHafXz+e3g3N1pBCJdfg1YlN4vz8n2TX2rReqI9gQoVI10RY/BOl44OhafexC3qv12JA/7vRonjxsvwv1H4icNHLXUmjtJ8PJgXAV6WlIMz+k6NCV6L8YNa2ptduSqGCXC+r1YdX1aIRFN53X4/oyCC7SVhsDLz0ii69UKoBg72d9DZ2HyDJ+7mvhauWO8SdAnI/r3MAnhOZe7obADJVslM8bkXdO1XZb3jshLa/p0pdxSAIF8KeY5W+t9hqsH2KgUwZdN9L/nZ6nFmohpn4qrJyNMZC/LnLIWCzJiTAScCkMylAe7sza1p7PZpPNBpTpEp4QD+Sir5zWr3SZWvXGpzp3T9kGiu07DQD+4Urq4fOlJGDJTLpm/6grzz7oQAXPMxl4ONY2NMKpppE8lT2JvM8l4/kEqMQrnXjEVGO99fY3aBLU+TXXGRHbuDMUZm8IJ3dIQoLwHOS2NW8ZaW8lS2vz/bnrIPFyAnvX1L99uEg31YEGJwHXNa35xGMoyxMxvbEiMIE58fbVm/9m5V+7gltQUIX/cNpI3SQ6Mf3WXwTCZH3MLXk7z/jpfG3gpAu6ftyAv+MYrmFDeagZ+jNeed3AG/iImF+zC0I7UwsCal3nh6DHJhenh5TLJKp1O/WFhLTC/fqa4k5IhUvOzK0Zi9aRtOHZ4CO4EIRgtwzB7QBPb/LAVJrg0PokCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199024)(186009)(1800799009)(86362001)(83380400001)(478600001)(10290500003)(55016003)(4326008)(5660300002)(41300700001)(2906002)(82960400001)(12101799020)(26005)(7416002)(9686003)(71200400001)(316002)(38100700002)(122000001)(54906003)(6916009)(66476007)(38070700005)(64756008)(66446008)(66946007)(76116006)(66556008)(33656002)(8936002)(8676002)(52536014)(8990500004)(82950400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sCJ05RxPK+vTQZJ+Dx24dMh+b+ueHTufRIgOqGuyUu1PLxyk+9okusZKBhaW?=
 =?us-ascii?Q?YqXzWONMfDKW1XGZ6glzHKQCbQfcY6bI1vUGCaYc1UDu2+APFIhyHpk9MC+0?=
 =?us-ascii?Q?ZCuTsXWddo1TWWIrQ66ojiv/LVK2/r/RxMkWDMjd07mlpGnFFdlaOvw8SLmF?=
 =?us-ascii?Q?PCYYbO76CIoaKUFzVOvMf3MzOhnDlrmjGQc7oKfNduExxx3vhs1zW229MpGh?=
 =?us-ascii?Q?G1PSTozoQVc3aStMNo0XEUSVPvEjg+c9Pgst2IYvauvmcdCvexlCZyX2cbL0?=
 =?us-ascii?Q?oCqdqoAZ1Ul5i9aMoAzssMHAYvm+AHopBkE8L+dDz6FNMX+kEDLkrKbXtzhv?=
 =?us-ascii?Q?0oXBKAXeFQoocGW4MmTuCZ2iaP0DKwxn//4OXINkpD3TFsURFoP95gfskiui?=
 =?us-ascii?Q?DGg6Vnbe9eN0P1ph89Xmf16P8bO+ORB7bBDgVGuK4O9CNjg7A6tziH8kHg+J?=
 =?us-ascii?Q?FYQzA/DklRo/SBDtTb/kGd1D5pZSopDrXPyOtNZrs03s+MZL8iJ1O2PUvNnl?=
 =?us-ascii?Q?SSxIMrdlVNXv9erCaYnjElVY50l5yuwUdFdtNPAcA+tK0A5mxnVagPdEI+5p?=
 =?us-ascii?Q?i6P0OUlfUP/DP9HM1OpnZdwaoevlsngMGyhO6h8WHTzN+C2nPUO5v6F+ecXO?=
 =?us-ascii?Q?JeHVzJmt1UQb/JaIHcnwnGMRqcBs9j4GdYEANfYKIDcD38D7WB1z3lScTkBq?=
 =?us-ascii?Q?kcBB0Sf9Bb5qO5O/+q/hDP5dnLg8B3fjG4B112RvU4/US2/mkd6LIVS9DPnx?=
 =?us-ascii?Q?oNB6js2sU33876qRbI5BLk0HJtQU1xCXZNdiCeMEh+X1JvVA3G9/QcXB2iU2?=
 =?us-ascii?Q?1sQCRtWfZIHSQcerjNrCQ0G/HQAX8glrJmXujOn2V5sDNFIAOnYObxq6JLZk?=
 =?us-ascii?Q?yJZU764+B63hDl7NtgDpEMx1J2FLTucD+RkhCzRgzODIyBnin/20QBa54lfx?=
 =?us-ascii?Q?mEdwpcSjRlo/bSs42N/zgVETfQQemtzcFB3U+DEFV2Unj8ZzimY4hoy4Jllx?=
 =?us-ascii?Q?Uohu3RSjTiRUyHAsOkE+WCGd7qF1JixB0HGsfIEGmUwxo0WEvECB5drx33c0?=
 =?us-ascii?Q?i94ZOJOlQP75mnCRodLhNnQgQI+btgyoi33UmayxsbawscV+5GSOMwmqRIoZ?=
 =?us-ascii?Q?F+n3TLOdqU8T0LxvCVCI5dSCzxQ+PXZtRuCfRZcSRl0W/mEBfhuVQ2jCBSfq?=
 =?us-ascii?Q?RK6OpC6KApdU2nAnx+iCOPycy3FvGfzgwo0k13+8QEJweq0nCDtNcu6pcYaw?=
 =?us-ascii?Q?DHTXLZT/l+0Bz+KDUB2TwvWJ/VE/Fcwvt41Q4luRPoduZ87PRWvejwjIpxmU?=
 =?us-ascii?Q?c2po3goQweDo+sJ9OY7gCgTMdKkpMkQbh3DpPJ7IJnfQaEYjQlddZmchJmu/?=
 =?us-ascii?Q?LQfHYCqrpsVzmDcYtUBH7v3ogMI2SNXOSy+COeAl+WOIicT2gmPtndOd8zNu?=
 =?us-ascii?Q?ozSymYUbHW7FkMC3CTpYbDXlNGv+WphauwqJpzYISPEZ/DtjRtFEgOEBQfYS?=
 =?us-ascii?Q?xxevuwwXMp7UjIb2wwqH/id9iOZ1TwFxcSlRxjLg7JX5TNJ5l2yV3FKwKNSV?=
 =?us-ascii?Q?aMJjVcFFqCXBa8XNIhZdtUnlpKMHVqbmYw99dRRPK9OpG002kBfr9gFDLHca?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e38d0c-ea93-4edd-a3aa-08dba81dd905
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 23:23:55.1100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IsB78FEK+X7YVmyf7yD/iYaZQH2J/kzHNHlCujbpQLRxkW80Eww6gevoFkTjRcVG7oKmO/ecFlZDXNsKinWbyzkxchYGRBtF3fBohL8ZCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> Sen=
t: Monday, August 28, 2023 3:14 PM
>=20
> On Mon, Aug 28, 2023 at 09:00:03PM +0000, Michael Kelley (LINUX) wrote:
> > From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com>=
 Sent: Monday, August 28, 2023 9:13 AM
> > >
> > > On Mon, Aug 28, 2023 at 02:22:11PM +0000, Michael Kelley (LINUX) wrot=
e:
> > > > From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Tuesday=
, August 15, 2023 7:54 PM
> > > > >
> > > > > From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.inte=
l.com> Sent: Sunday,
> > > > > August 6, 2023 3:20 PM
> > > > > >
> > > > > > On Thu, Jul 06, 2023 at 09:41:59AM -0700, Michael Kelley wrote:
> > > > > > > In a CoCo VM when a page transitions from private to shared, =
or vice
> > > > > > > versa, attributes in the PTE must be updated *and* the hyperv=
isor must
> > > > > > > be notified of the change. Because there are two separate ste=
ps, there's
> > > > > > > a window where the settings are inconsistent.  Normally the c=
ode that
> > > > > > > initiates the transition (via set_memory_decrypted() or
> > > > > > > set_memory_encrypted()) ensures that the memory is not being =
accessed
> > > > > > > during a transition, so the window of inconsistency is not a =
problem.
> > > > > > > However, the load_unaligned_zeropad() function can read arbit=
rary memory
> > > > > > > pages at arbitrary times, which could access a transitioning =
page during
> > > > > > > the window.  In such a case, CoCo VM specific exceptions are =
taken
> > > > > > > (depending on the CoCo architecture in use).  Current code in=
 those
> > > > > > > exception handlers recovers and does "fixup" on the result re=
turned by
> > > > > > > load_unaligned_zeropad().  Unfortunately, this exception hand=
ling and
> > > > > > > fixup code is tricky and somewhat fragile.  At the moment, it=
 is
> > > > > > > broken for both TDX and SEV-SNP.
> > > > > >
> > > > >
> > > > > Thanks for looking at this.  I'm finally catching up after being =
out on
> > > > > vacation for a week.
> > > > >
> > > > > > I believe it is not fixed for TDX. Is it still a problem for SE=
V-SNP?
> > > > >
> > > > > I presume you meant "now fixed for TDX", which I agree with.  Tom
> > > > > Lendacky has indicated that there's still a problem with SEV-SNP.=
   He
> > > > > could fix that problem, but this approach of marking the pages
> > > > > invalid obviates the need for Tom's fix.
> > > > >
> > > > > >
> > > > > > > There's also a problem with the current code in paravisor sce=
narios:
> > > > > > > TDX Partitioning and SEV-SNP in vTOM mode. The exceptions nee=
d
> > > > > > > to be forwarded from the paravisor to the Linux guest, but th=
ere
> > > > > > > are no architectural specs for how to do that.
> > > > >
> > > > > The TD Partitioning case (and the similar SEV-SNP vTOM mode case)=
 is
> > > > > what doesn't have a solution.  To elaborate, with TD Partitioning=
, #VE
> > > > > is sent to the containing VM, not the main Linux guest VM.  For
> > > > > everything except an EPT violation, the containing VM can handle
> > > > > the exception on behalf of the main Linux guest by doing the
> > > > > appropriate emulation.  But for an EPT violation, the containing
> > > > > VM can only terminate the guest.  It doesn't have sufficient cont=
ext
> > > > > to handle a "valid" #VE with EPT violation generated due to
> > > > > load_unaligned_zeropad().  My proposed scheme of marking the
> > > > > pages invalid avoids generating those #VEs and lets TD Partitioni=
ng
> > > > > (and similarly for SEV-SNP vTOM) work as intended with a paraviso=
r.
> > > > >
> > > > > > >
> > > > > > > To avoid these complexities of the CoCo exception handlers, c=
hange
> > > > > > > the core transition code in __set_memory_enc_pgtable() to do =
the
> > > > > > > following:
> > > > > > >
> > > > > > > 1.  Remove aliasing mappings
> > > > > > > 2.  Remove the PRESENT bit from the PTEs of all transitioning=
 pages
> > > > > > > 3.  Flush the TLB globally
> > > > > > > 4.  Flush the data cache if needed
> > > > > > > 5.  Set/clear the encryption attribute as appropriate
> > > > > > > 6.  Notify the hypervisor of the page status change
> > > > > > > 7.  Add back the PRESENT bit
> > > > > >
> > > > > > Okay, looks safe.
> > > > > >
> > > > > > > With this approach, load_unaligned_zeropad() just takes its n=
ormal
> > > > > > > page-fault-based fixup path if it touches a page that is tran=
sitioning.
> > > > > > > As a result, load_unaligned_zeropad() and CoCo VM page transi=
tioning
> > > > > > > are completely decoupled.  CoCo VM page transitions can proce=
ed
> > > > > > > without needing to handle architecture-specific exceptions an=
d fix
> > > > > > > things up. This decoupling reduces the complexity due to sepa=
rate
> > > > > > > TDX and SEV-SNP fixup paths, and gives more freedom to revise=
 and
> > > > > > > introduce new capabilities in future versions of the TDX and =
SEV-SNP
> > > > > > > architectures. Paravisor scenarios work properly without need=
ing
> > > > > > > to forward exceptions.
> > > > > > >
> > > > > > > This approach may make __set_memory_enc_pgtable() slightly sl=
ower
> > > > > > > because of touching the PTEs three times instead of just once=
. But
> > > > > > > the run time of this function is already dominated by the hyp=
ercall
> > > > > > > and the need to flush the TLB at least once and maybe twice. =
In any
> > > > > > > case, this function is only used for CoCo VM page transitions=
, and
> > > > > > > is already unsuitable for hot paths.
> > > > > > >
> > > > > > > The architecture specific callback function for notifying the
> > > > > > > hypervisor typically must translate guest kernel virtual addr=
esses
> > > > > > > into guest physical addresses to pass to the hypervisor.  Bec=
ause
> > > > > > > the PTEs are invalid at the time of callback, the code for do=
ing the
> > > > > > > translation needs updating.  virt_to_phys() or equivalent con=
tinues
> > > > > > > to work for direct map addresses.  But vmalloc addresses cann=
ot use
> > > > > > > vmalloc_to_page() because that function requires the leaf PTE=
 to be
> > > > > > > valid. Instead, slow_virt_to_phys() must be used. Both functi=
ons
> > > > > > > manually walk the page table hierarchy, so performance is the=
 same.
> > > > > >
> > > > > > Uhmm.. But why do we expected slow_virt_to_phys() to work on no=
n-present
> > > > > > page table entries? It seems accident for me that it works now.=
 Somebody
> > > > > > forgot pte_present() check.
> > > > >
> > > > > I didn't research the history of slow_virt_to_phys(), but I'll do=
 so.
> > > > >
> > > >
> > > > The history of slow_virt_to_phys() doesn't show any discussion of
> > > > whether it is expected to work for non-present PTEs.  However, the
> > > > page table walking is done by lookup_address(), which explicitly
> > > > *does* work for non-present PTEs.  For example, lookup_address()
> > > > is used in cpa_flush() to find a PTE.  cpa_flush() then checks to s=
ee if
> > > > the PTE is present.
> > >
> > > Which is totally fine thing to do. Present bit is the only info you c=
an
> > > always rely to be valid for non-present PTE.
> > >
> > > But it is nitpicking on my side. Here you control lifecycle of the PT=
E, so
> > > you know that PFN will stay valid for the PTE.
> > >
> > > I guess the right thing to do is to use lookup_address() and get pfn =
from
> > > the PTE with the comment why it is valid.
> >
> > Each of the three implementations of the enc_status_change_prepare()/
> > enc_status_change_finish() callbacks needs to translate from vaddr to
> > pfn, and so would use lookup_address().  For convenience, I would
> > create a helper function that wraps lookup_address() and returns
> > a PFN.  This helper function would be very similar to slow_virt_to_phys=
()
> > except for removing the shift to create a phys_addr_t from the PFN,
> > and adding back the offset within the page.  Is that the approach you
> > had in mind?
>=20
> I guess in this case it is better to use slow_virt_to_phys(), but have a
> comment somewhere why it is self. Maybe also add comment inside
> slow_virt_to_phys() to indicate that we don't check present bit for a
> reason.
>=20

OK, works for me.  I'll turn my original RFC patch into a small patch
set that's pretty much as the RFC version is coded, along with the
appropriate comments in slow_virt_to_phys().  Additional patches
in the set will remove code that becomes unnecessary or that can
be simplified.

Michael
