Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22DF531F57
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 01:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiEWXrj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 May 2022 19:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiEWXri (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 May 2022 19:47:38 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2383939CA;
        Mon, 23 May 2022 16:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn1YEpZL9Q0wal+D9AUOpYJwqYahGwYed5Wcp8Cp0NkhQ29mUL6AHrsWTSHkrvvVIQeycR+bKANcFCJnTV9ovY1HUWqoy21WZqt8mfucEG9qv7ofqQZXjeXkBjm929iC9vDn+HSZEw/P+J9OQ/mc2FmZdxvYT5jyx8ClW63brXNV97/Nrb1UoeHoO0b0y1NMunpwMVCsuhXDfu9FvjxrOxjoRR1saBJfCyygL3sQ7RZHYhYO7bYt6wAygHrWp4yEstYQTIP7/zBRVhW6HaH4Qb7Xhq6xm4BX+sAgHN6Kb885nuD9f6j3daenuDbRLD/VDDX+YPirjQPAPH7ADFmyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK37Bd2nDbzpmkZ5wBjAHY0TnNKUjXJwJEj9YpgzQ04=;
 b=kq3V5smyXRczV0/egoj2lAamxYaSUVsDD3tywzcAz2UmkD18/qkdYNySSoWnbYcWYOdYYCh1uGircj9vxbBMGxj4TaMNSu/5zYAPGk5Obwhc3zeCka/LPdGyU+V91OLZxbLLmTTmA54vwYJYnaTGJitq2zoVNjdAgSy+XNQ61rJJDmzYMwDTS07Nrcm0z6FU2SuxEMmEbadqCqui1AWU+JDhmhmRQhkrPcVrNM026jCiMQgl5E6To41DgOG+mKIRfRBvqY2j+a7/ofKSFeHPq+eXWWzZwgRWJrFXdi5Cn1NTJBv52Bd6MibqQ6QTegYBi/PitB6EBN/JIctCheS3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK37Bd2nDbzpmkZ5wBjAHY0TnNKUjXJwJEj9YpgzQ04=;
 b=bufTXmFo/R73zaDipS5n1RwEdH7Rufadk53m377URGX5DS670OzOgazibUUd3QFYTS+4Mxk1cq6U5+4ym9tZx1o+uDeuuSiXEzRzBfZH6KIMJRKD0yCFGuTb4b/bOocaYxYGDCFcKTh+ryhzaYjDBQYHnPGsCvykLsae5n1pCqc=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM4PR21MB3561.namprd21.prod.outlook.com (2603:10b6:8:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7; Mon, 23 May
 2022 23:47:30 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580%9]) with mapi id 15.20.5314.003; Mon, 23 May 2022
 23:47:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vit Kabele <vit.kabele@sysgo.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "rudolf.marek@sysgo.com" <rudolf.marek@sysgo.com>,
        "vit@kabele.me" <vit@kabele.me>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: Hyper-V: Question about initializing hypercall interface
Thread-Topic: Hyper-V: Question about initializing hypercall interface
Thread-Index: AQHYa4MwWanTnVIk7UuhrK9xZH8gba0tJDAw
Date:   Mon, 23 May 2022 23:47:30 +0000
Message-ID: <PH0PR21MB302564FA43E1402AD13CC706D7D49@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <YoZB/+EYDDfowVbs@czspare1-lap.sysgo.cz>
In-Reply-To: <YoZB/+EYDDfowVbs@czspare1-lap.sysgo.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a183a278-57b8-4083-92f6-f2cb48c3bf56;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-23T23:34:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec12557f-3fee-4007-c7c8-08da3d1699be
x-ms-traffictypediagnostic: DM4PR21MB3561:EE_
x-microsoft-antispam-prvs: <DM4PR21MB356110200AD9F3297699E062D7D49@DM4PR21MB3561.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWjCvJIgg5RmekfVlb9ZvMbQ2jkfR7WLyicCiudNDcM2GdC44a6dI/w4ZISdQvm8Ki3je2rZFh6ZFRgJD4wT6zExXuzKCHaxb/ejvixYrkafIlw55uwCOrDXk4F05NEn6VDl0IfsMYxBrw+di5YYAgzp/iXQ58D4RYNUI7YDnmC9rOEtoS3uosfEWWFyTigZxlwRMKZvokN+suyq6+/0hesSUlmgQeBMpGrqpnn49Xvc2UmlTtGvYDN3AqpjjI2tJl2w42AT3fv0m9Ua5WhgXDCNpZ3+mhLvsHIpSAjWdj/RdOP2oJ/3qPp6DBG75JtENdxw7GjeuwgwOZU+i34dtu1ZwesVjzynFSs3HGZi6/esMNhFVqzEO3M0xEJ+r5ylwEZz8hIA1twzN25xWjzYeX1kspYAD5aFz1qbJbJhHhZHmMeKB3UVYtUnqGiYJ7CFDwV7midIsXBdQGKIQm0OeN2IyVZQ3dnXBLEwVzHNN04TjThkdm6xlOoaPv4srHjl46k3zNd/K1KASt85EUv4zuQ6RAKIsoXsqxc3UNshwn20tSkL5qicVQ0Fn1/Yz+MrNoPSq9yByAasvpLDqzaKsJlNlrGEDkfXkRUt23dFIzRYWId2wISwK+VlRTyOO/L3q3feAVAzQIZL4VJ3p0TSs4wkXJfA5MONM8qJdRgFP7jIfVeXg51vSgtK7p+gkUjP3s58GXRfNp8UvqJDQ0+kYJJs6EoG4PkWbFMhijvIW/7RSMFHqEGoRbd5gj8uAU19dPPeAY583FtNcStO0A+wdR/uoFTsrEpsMuinN7UQkZvP+lfgNED7e/VSQpHk3RORxMnzuJacD9ioVV8p4RYMcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(55016003)(33656002)(122000001)(54906003)(8990500004)(38100700002)(110136005)(6506007)(82960400001)(82950400001)(7696005)(316002)(86362001)(508600001)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700005)(966005)(26005)(9686003)(83380400001)(52536014)(10290500003)(8936002)(2906002)(5660300002)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4GTK6fmYe7Xv6ls0vZV5K+OsOkxDeMzaBvCnkfcIrdlPWdwLw0lg2Qk/ZaJL?=
 =?us-ascii?Q?pbg+yE1Us6nWhdE7DzMzYXO0xv7Vuv/RfCwweavh+1Am3xtPSdElXFNdzGqC?=
 =?us-ascii?Q?u7N8Vgk5LRCe3//xsuJSB/spTYBXe0YI+PdcB6/DLK/p8+DDLsmgjE26O5Sv?=
 =?us-ascii?Q?2Qx9jIAm4AtzMFbP797rRcRuiuJg7XZAub257WY8flEhjDrv8h66Belu2rY/?=
 =?us-ascii?Q?gZljaluNYA0xM71Df3tMP0/IJt4BYzln4e5T/dwVU4MmVcWS74/J2jE8QGYl?=
 =?us-ascii?Q?i5ABpkeGkE897H/sKHZTobs3mqZh73qv1l+LzWSudc4KBdd0GBmgd9RCZ5IS?=
 =?us-ascii?Q?HPYMURUmHS8vOx9W6T5nv4UAr5YKZP6oA5DutJGZwzlTTfmD7umXat9Znbpk?=
 =?us-ascii?Q?in06l4wpiAJwqot3Bap9acWq+OBYUoL2TTKCIHvoVQYl6nD/DCuYmqzyZvBt?=
 =?us-ascii?Q?hQfrUqkDadHYMz7PxyiXgRmr4a87/1SCfyYNpGnyd7Kzmz1QodZsH5h83Fum?=
 =?us-ascii?Q?SRIM2egr7RG1R2QTuDs7ZQMPqawSpdSqZTgccRJlbYlGR2Qah9bbSHqvgj5L?=
 =?us-ascii?Q?VMCwkCcOLx+sREOzhgrFCypodGNvyuQUoL77lZAovfmZUpp8ZWvLRc07JKYh?=
 =?us-ascii?Q?VqquTFreUYD0YRo5ouoLqUPp6Bn/scqw7YdL8CcjSWTwt7fIpPjzSvy5wq1v?=
 =?us-ascii?Q?XXoyayaT0LOUWQAPWup2Nyr6FWhdVm83Ugk1/AmBEO0j6wazaSKcHcdxUP31?=
 =?us-ascii?Q?O6c81bH4VJjsOXqYtu+rMCoyMXGhDQpPqREL+MurReorfxuG10AVXhHdu+Ku?=
 =?us-ascii?Q?RwVgEPtXQnXM/XLXnbI0IybHdO/6aUiFRAqZpRxkN56i27BPmI89v4tBiLIm?=
 =?us-ascii?Q?gHcEeCR2hNIeNgTg9Svs6VCBHpkGYP+rxUIo1oz2DaVGpOmMvLehTwObZntO?=
 =?us-ascii?Q?wfwmrKeUaNvOxTMA96HhhUPu8KtdNzhpXiP1vp8IpwIWKr2vuaeY5wXkXPrN?=
 =?us-ascii?Q?crJD8sTPDUJVtf8NpX2CUoixlGsWUEAwD4wgnvhp2hdQxxiV+ib8FlVI6tcE?=
 =?us-ascii?Q?o6KPAcUVOKhKXYlXa+gyiXFDZPPQYFEAKuCCzhMZagUgKZGsObxo0S63ZeC5?=
 =?us-ascii?Q?9Qvt0NhIr5hjgRi/F85+O1ToZy2jrLzciOHN/9wfVfkIyHaJf8VTPZitaGd8?=
 =?us-ascii?Q?qrch1Q1k4YXAuXESs21gJkalTbiWoSqLF4l/3CCtEf/cDBnBDQLi7pW+Z1gw?=
 =?us-ascii?Q?/H8aOqxRWTGZukqWJeu6I7MaVBdIQ/Nsj5A4z3HSSNyQo5kH/eL4jjGNvqXS?=
 =?us-ascii?Q?J3ljE+ONYi34ySrsnL66yHPWqn/sOEC54jkqJTqYeVbExfigIVZ1SBCVkEqM?=
 =?us-ascii?Q?1SOyB811pe4AbVT3wl8j67gLiKNusgPogPX77YMlNqbnXOQgx/mMcct6Mr4I?=
 =?us-ascii?Q?CdCrkr+MeC67Hs8YRXarOueiufkrLOUCGLZIzE+196Pcw5wXfl1QLPSN9DIm?=
 =?us-ascii?Q?UO7Nsa1IT/4u5IQAybE8cBRF331vwVgD6cqbaBkq3iY+mTJ6Uc/9Y4oF9cc2?=
 =?us-ascii?Q?5ntSkSD+GGMO/FBEU1KfU1s6Y4qRhgg60mViQ3TktROl/ApMPaTtrU/gezU0?=
 =?us-ascii?Q?2o3ukFzq0A6q1PKFMI9bZXCqt+xbiXpxrE+3jcf06mM54H0v11oZAFE1kvPi?=
 =?us-ascii?Q?MxKS74OJZQGFN5Db/AcWXLajUHWCvn03mO+LD3zt4CxHsnsDe/Pb3byMALZg?=
 =?us-ascii?Q?WAu5Z5rff6vmC273CxHyzwfB2RapRNw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec12557f-3fee-4007-c7c8-08da3d1699be
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 23:47:30.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrm3aPLTfX24HxkzeIGHGrXQ6EZri8QFwf1IX5KSLxbe1bnKio7IPyQdrVmtK2weE7j+CnuzzY4fDNdPjcaHp/dcqrP94gzHlcS5c5VL6wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3561
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vit Kabele <vit.kabele@sysgo.com> Sent: Thursday, May 19, 2022 6:11 A=
M
>=20
> Hello,
>=20
> I'm playing with the Hyper-V interface described in the documentation
> here [1] (version 6.0b) and I noticed inconsistency between the
> document and the actual code in arch/x86/hyperv/hv_init.c.
>=20
> Section 3.13 Establishing the Hypercall Interface states:
>=20
> > 5. The guest checks the Enable Hypercall Page bit. If it is set, the
> > interface is already active, and steps 6 and 7 should be omitted.
> > 6.  The guest finds a page within its GPA space, preferably one that
> > is not occupied by RAM, MMIO, and so on. If the page is occupied, the
> > guest should avoid using the underlying page for other purposes.
> > 7.  The guest writes a new value to the Hypercall MSR
> > (HV_X64_MSR_HYPERCALL) that includes the GPA from step 6 and sets the
> > Enable Hypercall Page bit to enable the interface.
>=20
> Yet the code in hv_init.c seems to skip the step 5. and performs the
> steps 6. and 7. unconditionally. Snippet below.
>=20
> ```
> rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> hypercall_msr.enable =3D 1;
>=20
> if (hv_root_partition) {
>         ...
> } else {
>     hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_=
pg);
>     wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> }
> ```
>=20
> 1/ I thought that the specification is written in a way that allows
> hypervisor to locate the hypercall page on its own (for whatever reason)
> and just announce the location to the guest by setting the Enable bit in
> the MSR on initial read. A guest should then not attempt to remap the
> page (point 5. above), but instead create kernel mapping to the page
> reported by the hypervisor.

Arguably, the TLFS is a bit unclear here, but the first paragraph
in Section 3.13 makes clear that the guest must select the location
for the hypercall page.  I'm certain that the hypervisor can not
pick the location and just inform the guest.  The intent of Step 5 is
to handle the case where the guest might have already set up
the hypercall page.

>=20
> 2/ The Lock bit (bit 1) is ignored in the Linux implementation. If the
> hypervisor starts with Lock bit set, the init function allocates the
> hv_hypercall_pg and writes the value to the MSR, then:
>         a/ If the hypervisor ignores the write, the MSR remains unchanged=
,
>                 but the global variable is already set. Attempt to do a
>                 hypercall ends with call to undefined memory, because the=
 code
>                 in hv_do_hypercall() checks the global variable against N=
ULL,
>                 which will pass.
>         b/ The hypervisor injects #GP, in which case the guest crashes.

I would need to confirm with the Hyper-V team, but I think the Lock
bit would only be set *after* the guest OS has provided a guest page
to be used as the hypercall page.

There is code in Linux to clear the MSR and disable the hypercall
page when doing a kexec or kdump.   This is done so that the new
kernel can start "fresh" and establish its own hypercall page. That
kexec/kdump code does not check the Lock bit, and I'm not sure of
the implications if the Lock bit were found to be set in such a case.

I'll check with the Hyper-V team to get clarity on the handling
of the Lock bit in the case of trying to disable the hypercall page.

Michael =20

>=20
> Do I understand the specification correctly? If yes, then the issues
> here are real issues. If my understanding is wrong, what do I miss?
>=20
> --
> Best regards,
> Vit Kabele
>=20
> [1]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/t=
lfs/tlfs
