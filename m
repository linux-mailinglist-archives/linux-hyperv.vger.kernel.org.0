Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED073631F
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 07:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFTFZO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 01:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFTFZM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 01:25:12 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020015.outbound.protection.outlook.com [52.101.128.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A51AC;
        Mon, 19 Jun 2023 22:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyfvhQKeP2US4+vvrHcDFwQrf7BpE1tXwXKe2cpt1qcXouqsQRFCi4Jtyp7DiPs+Enk/EzVi/UdJLGi9RizCWDpiCxsDzeONvQun6waMWf5nG8fAuFLUvyv8lTmlT+rtPB20K4B2mU9pNgLw5vbbGtgENX+AgfimKMu1ZTCmyMhm5lJe25xsPMZpsJnRp9JhskGIysC19N2kvnfKSsWVVKgsa/UsVkymYsSyExMoDFvttqUfFGUBqlTuxI3ETw4rho8Ek68PtPjJ4u6zmdycqA7xAtfQB3WLunRFKWiKY1vCpMQpDXXP/OFlIskFJ1XJpPekCFHxvJZVCRzLnecJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd5XojvryCOi3uii9G2kq6ZStAUPvChiQtMTYLTM+pY=;
 b=UIRWVP4Vtj/bSgUwMR1gKTIF90k/3sVNEjU59F4pzwVccb3dxl/fxPOWMgtEjlsmP0ZnwnMOoAWGYgptj9/5VyRw57cgSE9Athxz6jTK5Chtm19n3cHuFejsRholmLn6WYmBoSp+SmZxAqb3k5kDf5Zsl3lHdkB/AjwTa/Obeitn2H+HVyVy5Oq/nYfc3BvNZfQoZGq+RuX+gWsG5AaXmJWU9II4ypVhCqBCl8cFN+kQqigm6df83r6cxslJlguSJkOj2wrYaVymuvZHdi4At8T3iwB9R0BFccRFWb43PJyuC2ueK9uY1bwaF39Hg/tECBuHvGDZx54UDk+hVov2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd5XojvryCOi3uii9G2kq6ZStAUPvChiQtMTYLTM+pY=;
 b=UaXSkx/lbi5/nG/ZZ2z/vrxX72UaF3i//ZrK6YwLkNvb6tnnA3P3AX/Nvork7VuZMqrnzNi245CWCs81Xo0L68EvffVV/CKMfP8XnbpAuYto7lUrt0ppRCkZG5RjXBXYsQgcRfRzB7uf99jsqxAwJcstHVv/JhRKlDTcyPSX8WA=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 PSAP153MB0408.APCP153.PROD.OUTLOOK.COM (2603:1096:301:29::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.13; Tue, 20 Jun 2023 05:25:06 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6521.013; Tue, 20 Jun 2023
 05:25:06 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Thread-Index: AQHZnwV0dJHFjLU8M0ikMK1jJEcj8a+TL3RA
Date:   Tue, 20 Jun 2023 05:25:06 +0000
Message-ID: <PUZP153MB07492FF43240CFD055CF268ABE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-3-git-send-email-ssengar@linux.microsoft.com>
 <2023061430-facedown-getting-d9f7@gregkh>
In-Reply-To: <2023061430-facedown-getting-d9f7@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d40da97b-fc4a-45c3-99c8-e2bfdfb7879c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-20T05:19:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|PSAP153MB0408:EE_
x-ms-office365-filtering-correlation-id: 780875d2-d70a-43e6-22c4-08db714eb511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4o+mOvWFdwWAu25tPxqnipa3+kmpaqjFsxQBEgfd8jdLg8Pq0rGfq154X4WBkW7qEZnlim1PBkvqzGfBk8ib52VVy/3XxU8Kubuom6YN1isRXc9xND60FCkuJdWydzgn/vPMQb2KRN9gw8zFpdYNmKjB8Yp/GyxWvjHO/OslxXuOJNexxORdA86EWXRTVUeMt+eyWnL/zB0muicOTuVwigh8J1x10Rt74QEMgucCkiUrM7PjW+ShruzQ/uY/tMAz2j15b8XTuqPLv/FkI2F3HQddD/NK76hqs0EY7jX0hhqZqc8VxYGA5JJRTGdlE9XMh23EbCAcPedsYDgHZXRnCazQTVn99nQngmlu8C2Xbxn7DaOLaCKPHTZ+WgHOz5qIt3DkZqfKoMlnmKbIEacnNITqtwoYCj1Jw/02GBAKiaR+QTk0mgX+H237BJQttVnnoAR1Q65xkORTyFqSWJGLhGYL2HOdmizYSZPKNZmwCJ0cd9WrfwMS+F8DI3xTxImd56o3Yy0X3/DAp4abv+LXJU2MKi66HWGs1wte5CWZSOhRbcWt89wMjGc6Q/xRg82+4F7d26tpiT9f3zIxL5AiENmtCU6ijIRWqqmZ8LuxUoyGpIQX65nH1F2IszFfF8jYcQ/6eH1fGW9v990Tj0yYRBNVH/lebsn4Z1sn0EPfNOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(53546011)(6506007)(9686003)(186003)(10290500003)(478600001)(7696005)(966005)(55016003)(71200400001)(2906002)(66446008)(316002)(38070700005)(41300700001)(86362001)(5660300002)(8936002)(8676002)(52536014)(82960400001)(82950400001)(122000001)(83380400001)(38100700002)(54906003)(110136005)(66476007)(64756008)(66556008)(76116006)(4326008)(8990500004)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wv873DE/5tJ2dvESpb5JyAE/sVYMnDhoDLr02UhSeShmBFe6Wz9yBtyj0saw?=
 =?us-ascii?Q?d6zw7Pj3Hpj1fmvR14NxY9DBlHpLherz79siJDvfqJa2mBJ/Kx99XyAIKauE?=
 =?us-ascii?Q?ywdxqw3hhk4uyIUoN/QEnD8Gz/ECAEth7hXZ4A9cKDc1Je7Bfa23VQbuo1yV?=
 =?us-ascii?Q?/4na+vrh+jXHjyWlIZEth7kfKhGbAdKgXYc5fDyTmpybSkW79QbGfbOC3Zuz?=
 =?us-ascii?Q?SpxlmIPqikuQPLq0QC7jBHhgIdvTopQVLuna/PQgxRGQkeGcH0qMXbotX3/l?=
 =?us-ascii?Q?0M7xDsyoxVYt+tkHk5oxgY18vW/r+7/lSGOgFxM9Lkz14TBcf/NusX9SXozu?=
 =?us-ascii?Q?Ei3rbSxpGj7tgLhwJssOGBUQQUyDAiRXlYcxobgTol160VkUUYa/iwBAt2bX?=
 =?us-ascii?Q?+csaDVTMMGPpkdzFj+VGkvO1pqZz/6XkiES9vMYhXdupgEJwSE3hsAl3fDDm?=
 =?us-ascii?Q?7Vmcz5EMyW517Z3q29eh/zkfi0dWSXsFp2FYJNjXnT+OoZMjz6SgLDaIs4nd?=
 =?us-ascii?Q?XF28LnO/3P50ycPf/GU/ggIeZQddhO/X8/mavNgou2F22silrkVcL9OMlNos?=
 =?us-ascii?Q?JNIWAFkrpK4wjqmjvbTlaaVsQwsYeHO3MrXXKfBG/kw8b8xMUlscV5LXuUtf?=
 =?us-ascii?Q?zLMI0mQqTBDrpshSzmgqcpckQHa7r1yn7n7hMpNAm5OJAgOjjt5/FTCep7xg?=
 =?us-ascii?Q?A5NLwO2hjd7S5zxFY9enV87RvZT/J4S5FZxjrcdAnd+E/09ZZ3q29BF+sQJ7?=
 =?us-ascii?Q?rBcVkdDerFhBTT4aW770lNGnZD1gl1Uq5WJw0AN1/WmP5/XytfTPq8Tw8YGA?=
 =?us-ascii?Q?eDkriot5Wb28ut965W+AFEt1YIjm4SdiV8TRslkV0sXLTaUym4mRA8wKiPOh?=
 =?us-ascii?Q?JtVmW6KpNHBXni2MnXBScukKq+vra4Oki6c8auerlEespUlZqxlPu1DcSxxc?=
 =?us-ascii?Q?hbfDyA5SoOiKnKUtUlqA3GwtiyCztJBB9iP+lz4gmWOaixNVqebMrC4G3XKZ?=
 =?us-ascii?Q?RdVQIxaaCuRXLxz5xXnM0zdCgif4TtW+H/0akP9DTw3zQ4NE2UGe3hKOGvMv?=
 =?us-ascii?Q?dslLvz3GHDVV3XopnvzWT+dXe9ScfcjUYaDdRsR5lvAkk6L5ESR3RXmN7ORR?=
 =?us-ascii?Q?i8m7YzMeznL0hBrW22sYLqczL7R2iiEbeWLFASF+UmfNxMw7IqCRMakkaVv6?=
 =?us-ascii?Q?TBFVmIJ7bcFDgTd78CS9lHVyn9Zk/9aarbPKImRvRoAc4rkVBemXMokqIwZt?=
 =?us-ascii?Q?2v+grzxvjU7WFBl6yfPSWd1YA9IJJquMRXHKd+bN1hbT38IZpyCQcQW1+fEd?=
 =?us-ascii?Q?sWQZajbQ7eHxbxr6A/QkiFeSNzBQl+cAwc/NYDg+fE3HwbmAlgC23j8YWnI8?=
 =?us-ascii?Q?9qHzZOPlCjIV0Ghls/8G1qZ9U9ACkZhW3WimONYjWNhEBJJlZz9cC2oTmRyh?=
 =?us-ascii?Q?POaCdXoKf5SUSndJzLp9HLgYSwXZyanbBhjvG6DsxWHvbqs9/Ol2NCSjhGZB?=
 =?us-ascii?Q?bLYagVO0IGY+mqqHGtTYP+4Tm705WgLnHArHMf/0Du/G6KzCApjb3/Zg5CKP?=
 =?us-ascii?Q?XEMXupTq4AEhVUq9WM8Oq1Rt7sjbrVxdmmJCPZNN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 780875d2-d70a-43e6-22c4-08db714eb511
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:25:06.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DTPm1ntGc6GlsXksfDz0in7d3cP/PMmmtPe1/tXTU4fiwLkw9OSPV6Ui8+eEMbGyYk2p3o3Kf9miScNFr+c2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 15, 2023 2:46 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> corbet@lwn.net; linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.or=
g;
> linux-doc@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
>=20
> On Wed, Jun 14, 2023 at 11:15:09AM -0700, Saurabh Sengar wrote:
> > Common userspace interface for read/write from VMBus ringbuffer.
> > This implementation is open for use by any userspace driver or
> > application seeking direct control over VMBus ring buffers.
> > A significant  part of this code is borrowed from DPDK.
>=20
> "  "?
>=20
> Anyway, this does not explain what this is at all.

I can elaborate more in next version.

>=20
> And if you "borrowed" it from DPDK, that feels odd, are you sure you are
> allowed to do so?

I will confirm this internally before sending next version.

>=20
> > Link:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> >
> ub.com%2FDPDK%2Fdpdk%2F&data=3D05%7C01%7Cssengar%40microsoft.com
> %7C79975
> >
> a82b7b44c67b0b508db6d1c9301%7C72f988bf86f141af91ab2d7cd011db47%7
> C1%7C0
> >
> %7C638223741757437265%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQ
> >
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata
> =3D100fd
> > FVed6C5lBrikWqkWwFpfH33LHF0H8fuRb0myL0%3D&reserved=3D0
>=20
> Not what a Link: tag is for, sorry.

Will fix, thanks for pointing this.

>=20
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > [V2]
> > - simpler sysfs path, less parsing
> >
> >  tools/hv/vmbus_bufring.c | 322
> > +++++++++++++++++++++++++++++++++++++++
> >  tools/hv/vmbus_bufring.h | 158 +++++++++++++++++++
> >  2 files changed, 480 insertions(+)
> >  create mode 100644 tools/hv/vmbus_bufring.c  create mode 100644
> > tools/hv/vmbus_bufring.h
>=20
> You add new files to the tools directory, yet say nothing about how to us=
e
> them or even how to build them.
>=20
> Why is there a .h file for a single .c file?  That seems pointless, right=
?

This is a header file so that any userspace application can add it. This fi=
le
Is used by fcopy application in [PATCH v2 3/5] of this patch series.
If this is confusing, shall I merge 2/5 and 3/5 ? I thought better to keep =
the
common library code as separate patch. Please let me know your opinion.

>=20
> > diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c new
> > file mode 100644 index 000000000000..d44a06d45b03
> > --- /dev/null
> > +++ b/tools/hv/vmbus_bufring.c
> > @@ -0,0 +1,322 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
> > + * Copyright (c) 2012 NetApp Inc.
> > + * Copyright (c) 2012 Citrix Inc.
> > + * All rights reserved.
>=20
> No copyright for the work you did?

I have added 2023 Microsoft Corp. Please let me know if I need to add
anything more.

>=20
> > + */
> > +
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <emmintrin.h>
> > +#include <linux/limits.h>
> > +#include <stdbool.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <sys/uio.h>
> > +#include <unistd.h>
> > +#include "vmbus_bufring.h"
> > +
> > +#define	rte_compiler_barrier()	({ asm volatile ("" : : : "memory"); })
> > +
> > +#define	rte_smp_rwmb()		({ asm volatile ("" : : :
> "memory"); })
>=20
> These aren't in any common header file already?

I see every userspace application is maintaining their separate copy of thi=
s.
Although I can remove this duplicate define and can use only one of these.

- Saurabh

>=20
> thanks,
>=20
> greg k-h
