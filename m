Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49B5E8184
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiIWSJR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiIWSIy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 14:08:54 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3C29CB8;
        Fri, 23 Sep 2022 11:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXuTMhG6ayZ/4/s1oaQcmG4V0VOlcU+Jc9SfFmXv+mW+8Kjjlf8k03wPZBPS0jZSldJj/yU9XrFifFwMeY0ZBQwr4xxsBdDowAC6WMKa95zmD9tWUDZUHVSVsl4sJ1Z0x18hdPtditxZ5j3G0jGXX6PMpYt13VdYBqRAySxUilUIRzpmggOzXyI4TndRNfHnd2DK+OPmac+CO+Xp1Ub1iHZ2MCHO+G4osMc5dVs6qs+JkmNv6vdJyl9qrE+qbIHRBlRkqWu5t40FZy/1p95zFd/LnnU01YC5ZSH/j6y0CSaPy0LZy7dpJhCX0cvj3mS6ju3gS4EvBI5shb1WVt0XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOAC1xEn6MHnVQGsFdxDGSobiTwS6rCXbx6AoBjxMFI=;
 b=ap0qRPhAZGHstYQFTcEGXOjr8d/hFrO/hHTmlg8yTxhxxrfNbhjbb+h5QBau0m8V9XdSbVsb2nrSujmO67TwRDqfeRdtkfcYuKwsroTYO4AObZfoMxcZW8tQP2unmiY0LIVRJdIhUE0xuacZsqEzazZmxdIcO9HRnkz9Kg4+xaAMbXE2fajuA1fEY6lK3hEkPD1kN+9iJFHwZrgy0nSgc+08cMt/5fztkf8Zvs0liSSM7hn4l+QVpFrpWrc0N1gNBRANdq6/u7IznJQhWKLCdapk6QPglB+ySHCS61FP+GSabdYpnjSObdKs6rBHRWvmwCzJUcsB/R3RbMwaNiiPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOAC1xEn6MHnVQGsFdxDGSobiTwS6rCXbx6AoBjxMFI=;
 b=bK9PKClZCWN9ecUW4//2IKg5XI5Qx/WvPABevKfaBPN1AkY4GGwmxS00HznZGVHP3L/2FMa1hjinqKk51Y7fUFApl4kJDHvV4zoY94zcE9Tlkj+/ptewD3KWYNmBvtavfb8wvrjKQh1hXFBozIAAPfXFEgAew6h+sLlCnDwshwE=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MW4PR21MB2003.namprd21.prod.outlook.com (2603:10b6:303:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 18:08:23 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::ce6d:5482:f64f:2ce6]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::ce6d:5482:f64f:2ce6%7]) with mapi id 15.20.5676.004; Fri, 23 Sep 2022
 18:08:23 +0000
From:   Long Li <longli@microsoft.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Yang Yingliang <yangyingliang@huawei.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH -next] RDMA/mana_ib: change mana_ib_dev_ops to static
Thread-Topic: [PATCH -next] RDMA/mana_ib: change mana_ib_dev_ops to static
Thread-Index: AQHYz1qPl+EAlQsltkSt/7Y5//GtzK3tFvwAgAA5LJA=
Date:   Fri, 23 Sep 2022 18:08:23 +0000
Message-ID: <PH7PR21MB326302DA622ADD2D903B770ACE519@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <20220923144809.108030-1-yangyingliang@huawei.com>
 <Yy3GErfUGlJcozHK@nvidia.com>
In-Reply-To: <Yy3GErfUGlJcozHK@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=afd9807d-475e-4923-b5c8-f6890422ef0f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-23T18:08:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MW4PR21MB2003:EE_
x-ms-office365-filtering-correlation-id: ff085c7e-0d1e-4cd7-77e8-08da9d8e9ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vypd1fxgSjMWiYUoIrZbkM4lzpSpDchUByV9cvxJPeV5RnQboXfEtRF0MUls1aJcvDrU02HXW7EtXvQNLH+JAKfF9/Sv8iD5+EXoEupKEfmbrSOQE7YzB4ySAhu29N0zQNzypAtISC+atfvySbY4YFQb8M8hWYyDVYx9qz9/T4NXJJg2y4oxW3FdPHMXngZQ/cyzU6ajn46chpJo5233r16R5b5lg/1ybKZEMAEwh5cw+vbsN1Ov7RuDhkGTMpKNTPD7jni6RjOMKuLY50Uibex0sggGTt/sNINYQKKP0p1dTRwkNMiNxYMO3Er7KFp5DIcsA7/qsv1+SQiQBJvwLtUNAxXQDHBKsBqllq5QiHZEWnNgQc6MXXCKeVbo0t+mRzRiAU5fqZQooXbP/phlGOqUObg1ExzwT3hiSk/2NxBjYW9f8xwi6UdT09syDlH5wQk/Lji3OJlw1ctLpuepP3pE4vmGrt1UioUycw7pbewHG5azuwp20+7i89q92Ofd1CiZXW2uk0mHPLSb2zSVvzot4h0uxLi4L7HdFER58fhilbv4sc0yrFQAQx0RA+34aqW3EckEF29YlJtQ1W/pVauKYXLWXqQY2rOSNUvZgmTjCH71ZCxO4Q23YvYCfNfzQMl1maYb2V+YfnE3t5INUC0HA30lWfXuh66vT1eMOr6fRXzOmMC9nuWB7MLUUhQyzu9ECQBFi6sZrgZWfv9GIUJ1Qg0gSg3Bf7v5BQ2OZ5fOGti2wNfjxsrJiYZtlwQ2C9u7WaV5cgfvnySzZ0SidMu3bcA3jrMBEWn0vtJkuv/XbWbky+4GP4vGlCqigm8s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(10290500003)(26005)(9686003)(7696005)(6506007)(71200400001)(66556008)(82960400001)(110136005)(8676002)(66946007)(4326008)(316002)(66476007)(76116006)(82950400001)(38070700005)(86362001)(38100700002)(122000001)(33656002)(64756008)(55016003)(186003)(478600001)(8990500004)(41300700001)(5660300002)(2906002)(4744005)(54906003)(8936002)(66446008)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YKji1REZIvCK0nsaNO+vdsXj5FjIxE3HwRNB/B93GpL9OeWFNuRL9yoV281o?=
 =?us-ascii?Q?7N7153ibOTGgm4uYjSM0XYQnAmoOCJjTC7KxIQYfah7n5t0htp43muZKRuRK?=
 =?us-ascii?Q?xaBhBBuK3HSwC1uqWXBqdbDG/6KLNbjZOI/JdpwTOrm2jkHHIaMsGG4Xkokk?=
 =?us-ascii?Q?UbQqOb4erTEFOu0muaT/J8ED04o32bDJrfS4lGhuKnoFlQPt79cyJGH6mKo5?=
 =?us-ascii?Q?ZzlS6udHJkSAM1UsbwyIZBNmsb/MNs/ROzV3NlvA74Ra4ffF7qhlx/sYDdLY?=
 =?us-ascii?Q?naqLTV58evrjz610ak9mMAhyLWsGdBWRgdAMrtbYhtRPqWoeaJTIXwBzLwJP?=
 =?us-ascii?Q?V54SizkUHrDBY94LobqiJV8ZaXDRm/326kcov6Yl3simAYIy+NGWuxHuG3jJ?=
 =?us-ascii?Q?4nG86dYHEEhUltAphQ0CGEvczhqk/1D9wYmgXx5m8rl8vO5fWOplY2aDtISI?=
 =?us-ascii?Q?+mcE/8xYMb1ijGAmaa/ew18TxV9d026SnhnYNxmVaer7QV2amlxmww5anouG?=
 =?us-ascii?Q?dg7rMrW5L3jGtDk3QClGj/WCWcuco8hbYNbTAbKYGeuMFoCYpgIYG9ukCF6e?=
 =?us-ascii?Q?FE8OA5xiHbI303/eNirHpZbDe0P/U/+3GOxbSlspHrMP7Xqq2DtdNdTOQZ2n?=
 =?us-ascii?Q?RELb16yirEumrALUm/k4jx60UdHNLvDE2UNThV6V+OMWoiH/TQ64Ph2CHON6?=
 =?us-ascii?Q?B/oZcr0jurGg8G5GVJG0U4lV9ReMb6RDia6HJfasmFrsPeodeArUYUtOH9l3?=
 =?us-ascii?Q?t/CjADttZRuHpdxlovBcjEr2Yg5W5r9PLD0doEoqdMHKUa4LJ8cPJZHWVu9/?=
 =?us-ascii?Q?FSa+9xld0hy/ZUVLJaqhyT3C/vWIYOtZqZwgn5ePKz1G8PJKYDL24aVobni9?=
 =?us-ascii?Q?duT6TLHEFwRGsgXm82oOYDv8FZaQFy6i11sOHP9gu6EaKaQR+407PQePAmxs?=
 =?us-ascii?Q?wD6rzpeoDJSaYH8t+HknVX1KpZK16fk1DoZ5Eo2AUnYxxrd6DQbNQlf3Nb9/?=
 =?us-ascii?Q?6srdZ26p+OUj0tV/+rWOntpZdEwINiXwlkL1cFW6UXi6VLSM+Wf6ZxLh8WsR?=
 =?us-ascii?Q?7Zs0Nedi5SV60YwP90Ops4+lgjR2+zIsIMFFAElkLrU2MVp5Ggq9g8wuyUcT?=
 =?us-ascii?Q?/zuiSKa92I8uER5KJShNQMMbHB0Niki7oRRm/LJ85g4MPt1IRtSCY/seH418?=
 =?us-ascii?Q?qd8kgQlTdeMoUky5uO41rhMu7A8RTIPDqkyMZVBRrPTu5QcqhVUei2G3hGB8?=
 =?us-ascii?Q?u5YQ5jKbfxk4H1PB+XDlEjHVHPkanQKLspg4XfA5Tt+SNfTCJKpy363C6hEW?=
 =?us-ascii?Q?PfWCwtvy3c2d+Enjx5eFUBwRhpMXQdbfnMJYrRDuNl50j8WeFzXcj2drhJfL?=
 =?us-ascii?Q?K9wCM3F207egDZ1g9zYNsqAoN9VVZBK81ZM83pKvm82xeJERJMrHyxO/EoU1?=
 =?us-ascii?Q?p0HlCeBwVJiyl83bghSf2v57U7PPiGAk0D3mdRg7xdpV5egbVQPWo5nxpnwo?=
 =?us-ascii?Q?7ekjxFNd6Bb3pqfIbQM2aBywTIf5YvUuuFvocWq4LPQTn8PyVMO0jHlEx8cM?=
 =?us-ascii?Q?c6+1LhC/H4Q3vRJOoYbxFFzxRBF15AZ6euMyJi2L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff085c7e-0d1e-4cd7-77e8-08da9d8e9ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 18:08:23.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cz+Wa7n3/pIKpvOECz5Y4EfjErpFZ8iDVKjyQOA0mcD8J4bXkCRyFEBELLkJVGd5lMIjx/h1VzBiqbMlbZjttQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH -next] RDMA/mana_ib: change mana_ib_dev_ops to
> static
>=20
> On Fri, Sep 23, 2022 at 10:48:09PM +0800, Yang Yingliang wrote:
> > mana_ib_dev_ops is only used in device.c now, change it to static.
> >
> > Fixes: 6dce3468a04c ("RDMA/mana_ib: Add a driver for Microsoft Azure
> > Network Adapter")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/infiniband/hw/mana/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Microsoft folks, you need to squash these sorts of patches into the next
> version of your series and repost it after a few weeks. You will probably=
 get a
> few
>=20
> Jason

Thank you, will do.

Long
