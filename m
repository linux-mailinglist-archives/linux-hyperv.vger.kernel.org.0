Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE7532294
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 07:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiEXFni (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 May 2022 01:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiEXFnh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 May 2022 01:43:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D928939CE;
        Mon, 23 May 2022 22:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4aYYvDgeCbOyiUTdmN2p0nIOsnYS5v3vdGdt91BQo1018oVFZ9Gienys5P60EucRVA/teGyeBMQw+A2hRlkJl5iuZweyix0TIRt+kKsTAgb7UwTS4HZWkITrz+wO7OfNPy7/kGxnL62cf8JMA7MuX4PVUZuoUbL2SzS12Rnsqfdsui/AdTtyG0IHEhQxMK6ORs17chhBpKNrvutjJGrnxDsUY1bBAgLlLXiK5yNtaxwEqIpDIZRlSIpd7ouYIhj3v2XpayP8JoMooAhx4ftkhppqAWsuXdJm94wkYaXtCrgrmnNqBemC4sEX+7T/DwJ8J6a9RCI/HkdsELzaTIwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyFE+hUZlshAFbvhEy1fUvUmSw2p4GiUXhs7uM8NIMA=;
 b=VFM5JAJ355D73wfZrXn5B/z+DA+actjjHi5p9Ie66a9oZ565xk/vu6Owaqcvn/06I4/QJlCkz4JaEFe+sdaip1AqxQL7iLaUd8Pszl6CnuRPMHXeGVzosPFmhEO6dB91M6EkqP3PNm7gCQeJ00tThp1IPvpLfNndXESkUJYbvh7UH3oC5c235dSSU2RIFw5jFf4xqY8QVUbpeeZqvorolTfRDf89o6j9QvZkEE7ajNc6aLN//wqTMuutlt/VgPHGAbFSVbR52B8efBxekjmfHPNc3nk7lNLU6ZvnHg45g0mzXstfeLjWDqpelux+MdXXSVz23Y1TPnwjhQIuP/Kjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyFE+hUZlshAFbvhEy1fUvUmSw2p4GiUXhs7uM8NIMA=;
 b=VWnVS8026Z8nTkOju3uWfDr1E9VY3goI7vgxDhZZdqMAiH8ByFVv5gfckNHjxBYh4lsb9B/SE/wkpkp3+b1hevBsEIWQkdvqrWxefopubrl31TIuZndccBUN4jEUblyuonFtPYrC3UCL2Mv4D3PX3cPCfv25dtVtxNoTlltWCns=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM4PR21MB3706.namprd21.prod.outlook.com (2603:10b6:8:a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.3; Tue, 24 May
 2022 05:43:34 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580%9]) with mapi id 15.20.5314.003; Tue, 24 May 2022
 05:43:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Vit Kabele <vit.kabele@sysgo.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "rudolf.marek@sysgo.com" <rudolf.marek@sysgo.com>,
        "vit@kabele.me" <vit@kabele.me>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: Hyper-V: Question about initializing hypercall interface
Thread-Topic: Hyper-V: Question about initializing hypercall interface
Thread-Index: AQHYa4MwWanTnVIk7UuhrK9xZH8gba0tJDAwgABmYHA=
Date:   Tue, 24 May 2022 05:43:33 +0000
Message-ID: <PH0PR21MB3025E5A04CBFE8BE3C4C51C4D7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <YoZB/+EYDDfowVbs@czspare1-lap.sysgo.cz>
 <PH0PR21MB302564FA43E1402AD13CC706D7D49@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB302564FA43E1402AD13CC706D7D49@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a183a278-57b8-4083-92f6-f2cb48c3bf56;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-23T23:34:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d428c1c2-d5f1-4c9d-8f2f-08da3d485766
x-ms-traffictypediagnostic: DM4PR21MB3706:EE_
x-microsoft-antispam-prvs: <DM4PR21MB3706AA5F313B5275AE56DCF8D7D79@DM4PR21MB3706.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODPBsYCgdEJCSoV0qBbtNM+XiziT+/dEek/wPQYxZRuYzDrVMgOCwdB7FZlQoJ/tyIj+42OydQN7wKitWwKQ2aJtLpqLYOBPIkd/HT4aiOfxxzSs3qH9fcX1S/NzlJrH4Kw96taK9AFpv/mssmIcpm7Rs+Ij2GHVO7vXsBTDPpBA1a8gxIzjHHus4MuIJH9l4USoEYyV4rfgAycnAPmYlh2rfQk5aU3IsaTEohG/cFcYQRsam/hFebK4vH1ChiROVZEXL4XxIUbrZhkNTHFcI/so//56dz7jygTgwB9Eeis7dwAJgf3VgEa0Rk72Oh2xazDu0/ncsBBx/6Gw7OvEBH60lpcHggKxi3NTeM7UidgMFAwCEWXnXZmdaooHgpS1twC0C6TzXzyYL16jA6WdoAgYWXDrNzxFBUTcvjXEuABcAnee3GezBfcFulJKNnBJw7I2DNjRUJzKa9Y3a9IblvijSVM7Bf2hY2Km4gnLHsj9ri2ZtgPi1gCMHBhe7W/89cyZbTU/FG3p/GHJ2JR/1Tiv0SNTr3woSIDEGy0CX8ZPxG8lXIw0KWiF0L/IcbB3lZnrP0tKMF9owBhxN8ioq5Pwy0LPYnhDW458s47pCHLJLGC/2+ebI9E4A9L2EZJ/WI8GU9m066thKkbo01UzEvjSzroK6pVGCrz3/jd00ZltzXCuCWheupcK0yL0n4eh1zDXS4Ewk4ISVWU+ElfKKJBRnyo8xHN3w3ZVcj3XlYljuqxJUMYvYTqGF5yMGJZg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(186003)(8676002)(52536014)(38070700005)(64756008)(76116006)(8990500004)(54906003)(66476007)(38100700002)(66556008)(66946007)(66446008)(9686003)(71200400001)(26005)(6506007)(7696005)(4326008)(33656002)(82960400001)(5660300002)(110136005)(82950400001)(86362001)(122000001)(316002)(10290500003)(83380400001)(2906002)(8936002)(508600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6e2mqg4qeJh+L2JK0cJ4QvU9T8yuGeH4W1B2EJWFMrf5myL8hg1k6X7JhpmX?=
 =?us-ascii?Q?1yyU9ysh7NZ0PIff/pMT2jyVX+aOO9syJKdT1XwybVpVyQpNrkcM6QSIANFc?=
 =?us-ascii?Q?OnITDGv1KauycWP/LwFm1M/4FWjhKfA+SfmbbrhA2IKAvzJARE2uHljvE25x?=
 =?us-ascii?Q?wuRDps1GzF6tEbRLLCBo6j+MM60sZyG2eQaI+ONNuLL8Ubhp5giphQ+Tmhwd?=
 =?us-ascii?Q?igXtDh0DWcD7nI3FIOou80JudGQ/jn+XNiyDA/0QRkvpnuy1Tq1s1p+clKkV?=
 =?us-ascii?Q?/QpzbUZ5ijrkrpoyY4ZlUq5reY7t/lkLbgbaRAl47Z+dWyvBwC6XzXQS/HBN?=
 =?us-ascii?Q?GB2aYnmEe6NVH5zOhdGn1HOMC1Iq88tjzb89xjtGl2RfX4o+xT3T/VDxDbWq?=
 =?us-ascii?Q?Ziit6WSUyp2R/UXl4ZHdOuJiq7naxjaS/ApySoDZFQuRwRwXdvdtBUnkOaoX?=
 =?us-ascii?Q?O8HoV373gw/SIA95KUVoyhXnR8GxQsbWZNQbyYKtZx8bHLqqGIebDBb8rBPA?=
 =?us-ascii?Q?EW9gGibeE6oNdEQvZ0m1uDEw0tfsDPZFShdCNkU8/dLVO5wJFpICZmBbBrZW?=
 =?us-ascii?Q?rxgYjwq/S59wBURjgTtoezlL+NSC47bQjDUbhvr3Mq4VI2Q30R/D7ITfh0UP?=
 =?us-ascii?Q?sxaPrDW7Th1j42ESRb2/WEqWxlScMePU3K9MomhWzjNRFREWId9JpcA0nbT7?=
 =?us-ascii?Q?F7UKSUkwXM0q1jO5qvpQD/TSnhlw1buJLssuBCUfMyKON56wrjqqonXVAidW?=
 =?us-ascii?Q?cpqxnO0cvvXGcBneOz4iUfKguOxojGS09w+MpfOSOPW66ykA/sXoLn2c/KLh?=
 =?us-ascii?Q?Zlay9Kr0C6keP6WuN28f4o2Nh95lE8cubdLqECEr/j+zqG0sUtmZj7wEQ2W3?=
 =?us-ascii?Q?N1WoEriGm4+f0XBPVnQv0UOPJ2z0nSYQFa3e+8/pv8KMF7USNd8OSjjHpFoL?=
 =?us-ascii?Q?RtZjHnO8KMhYKqGK7xHsFrxye22beI/Bj4jtOEljHmc3/AAIjhNxbCFQKyHu?=
 =?us-ascii?Q?hK5LG8PmthoXNuisvt93ovLjFkqXj0oa53fmjxoFaxHWmF8+ik46NmAPxJhA?=
 =?us-ascii?Q?nfsb5oZxlN7YSwRJuyZ+fZqNMqRp/3fCYUW+K4KTfvO/MASYBzoN7YyBFoUP?=
 =?us-ascii?Q?V7EoDesib7Kbdgv8HIZqvDLkEChnJuv+5m2ZAzWjkmcEA1epHT+GpzuC/H7c?=
 =?us-ascii?Q?uVvAjXbfztt9hNCTInKr4WsOHThqrtJOhDMHLT1ln4HlfftuWED3XhLaFkR/?=
 =?us-ascii?Q?zXxcJcohbnYEq9hAZk0VvbMrIb6Q3xVuwOxoz7COBI+lwNG9FuYwSy9hFTB1?=
 =?us-ascii?Q?3vbW+LE0kvbUFDrHtnycmntlIbbMY5iuWh6tSqRVGlUOBz3OLVIxkakMW8Rn?=
 =?us-ascii?Q?e+0LeduRoimlTydP8k+b4uTBMxOPOyLm61Qd7L51HgeXOiykY+Hhov/BAn81?=
 =?us-ascii?Q?UKTo9N8KpYT+sUwhqoQ1JKND87QClhka/X7paprZmi92wLnmU9vkqhH/BnFZ?=
 =?us-ascii?Q?gu7vpLjM2ozXWSIqTdq48RhlmQf1ppxMsJ/5nFdSoGPvz5mRc40nFzIvDY7g?=
 =?us-ascii?Q?hmF4UwU/LysffZlFz0cZb/tUahtSm+kJ5Umd2WrRWOy7T2VKWlP6jL01W6Ym?=
 =?us-ascii?Q?9vMj09wtD5/UC09gQ2+/geZuKau6EkIxoRpi87ddgStjUlGrXwr19dnav6d6?=
 =?us-ascii?Q?VL+qBo+vyFgXNl2aDoegRH0B4/4TacsXWHp4xQLqKBcNhwhsaHjJTkIBZ51s?=
 =?us-ascii?Q?mojVpy8noYiyoQCmS7jFFwVDPD1NCWM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d428c1c2-d5f1-4c9d-8f2f-08da3d485766
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 05:43:33.9000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yV3c/ooy4yduSBf+qfD70dmqIqRA5IbJ3szzMx1kYqYGdybpNGIgUetgaKhS9/XeQ7c1U6WjXIQOxxz8hn1mEKYIjNycnt0MYqYAi0+qjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3706
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Monday, May 23,=
 2022 4:48 PM
>=20
> From: Vit Kabele <vit.kabele@sysgo.com> Sent: Thursday, May 19, 2022 6:11=
 AM
> >
> > Hello,
> >
> > I'm playing with the Hyper-V interface described in the documentation
> > here [1] (version 6.0b) and I noticed inconsistency between the
> > document and the actual code in arch/x86/hyperv/hv_init.c.
> >
> > Section 3.13 Establishing the Hypercall Interface states:
> >
> > > 5. The guest checks the Enable Hypercall Page bit. If it is set, the
> > > interface is already active, and steps 6 and 7 should be omitted.
> > > 6.  The guest finds a page within its GPA space, preferably one that
> > > is not occupied by RAM, MMIO, and so on. If the page is occupied, the
> > > guest should avoid using the underlying page for other purposes.
> > > 7.  The guest writes a new value to the Hypercall MSR
> > > (HV_X64_MSR_HYPERCALL) that includes the GPA from step 6 and sets the
> > > Enable Hypercall Page bit to enable the interface.
> >
> > Yet the code in hv_init.c seems to skip the step 5. and performs the
> > steps 6. and 7. unconditionally. Snippet below.
> >
> > ```
> > rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > hypercall_msr.enable =3D 1;
> >
> > if (hv_root_partition) {
> >         ...
> > } else {
> >     hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercal=
l_pg);
> >     wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > }
> > ```
> >
> > 1/ I thought that the specification is written in a way that allows
> > hypervisor to locate the hypercall page on its own (for whatever reason=
)
> > and just announce the location to the guest by setting the Enable bit i=
n
> > the MSR on initial read. A guest should then not attempt to remap the
> > page (point 5. above), but instead create kernel mapping to the page
> > reported by the hypervisor.
>=20
> Arguably, the TLFS is a bit unclear here, but the first paragraph
> in Section 3.13 makes clear that the guest must select the location
> for the hypercall page.  I'm certain that the hypervisor can not
> pick the location and just inform the guest.  The intent of Step 5 is
> to handle the case where the guest might have already set up
> the hypercall page.
>=20
> >
> > 2/ The Lock bit (bit 1) is ignored in the Linux implementation. If the
> > hypervisor starts with Lock bit set, the init function allocates the
> > hv_hypercall_pg and writes the value to the MSR, then:
> >         a/ If the hypervisor ignores the write, the MSR remains unchang=
ed,
> >                 but the global variable is already set. Attempt to do a
> >                 hypercall ends with call to undefined memory, because t=
he code
> >                 in hv_do_hypercall() checks the global variable against=
 NULL,
> >                 which will pass.
> >         b/ The hypervisor injects #GP, in which case the guest crashes.
>=20
> I would need to confirm with the Hyper-V team, but I think the Lock
> bit would only be set *after* the guest OS has provided a guest page
> to be used as the hypercall page.
>=20
> There is code in Linux to clear the MSR and disable the hypercall
> page when doing a kexec or kdump.   This is done so that the new
> kernel can start "fresh" and establish its own hypercall page. That
> kexec/kdump code does not check the Lock bit, and I'm not sure of
> the implications if the Lock bit were found to be set in such a case.
>=20
> I'll check with the Hyper-V team to get clarity on the handling
> of the Lock bit in the case of trying to disable the hypercall page.
>=20
> Michael

The Hyper-V team clarified that the Locked bit is never set by
the hypervisor.  The bit is there for the guest to set if it chooses.
The TLFS is indeed not clear on this point.

Michael

>=20
> >
> > Do I understand the specification correctly? If yes, then the issues
> > here are real issues. If my understanding is wrong, what do I miss?
> >
> > --
> > Best regards,
> > Vit Kabele
