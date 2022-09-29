Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385765EFFDF
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Sep 2022 00:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiI2WCw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Sep 2022 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiI2WCv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Sep 2022 18:02:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A3D13A3B3
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Sep 2022 15:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJKuHQ4uEjKyeUpJJProjT5hedE8UrF3PJRnQJaJ4GQsjT8ZcrdSiphHtHzAKHTcc5tfCmbge/waw4dHJZWROtao3zZ4f4XlTcng86BJTJHuiQtoJQju5QwahHWbt61wJnVsX2ghWf7Z+hfXYHP0Bljg3EOSADFdCM1biUo4XWPav2UzJa+zQ19+3o5mgqxNdxpa9ywQxOk83oK9vmRwYvullHmLBaXeaTHp8NDWAgPkAgn7JC77jYvpjvr+tZmpH4ckdFNUnDsh/L4gPwUtdKOXpoKTTQUUwZSpuS7hUrDP8Y3LqC5JSG4hdKbQXd5so0KY7JaL/GwHoeYkhqXF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJXHDhKkp1SXzrIRDksbhwRvm+I4EKvPMFiMnkFx/LU=;
 b=TldiO09PBi3bazPXhIKzIpHEUQl3Jg/Hv5ttd6sqCCuhbqu/tEXBIUy8JEYTCQB3BuNQhkifWEyYtaCM2V3i/m4ZEomf64dK3SPOdaoacMMXy6oQBI4iBZEqVRimDTXxoaIdELxShw4jmYBiH0NPtCAI/VERdM64SVfr07nLupAAkZ87HS3vvNbDeDzmU+kPLAPTJ1+qG4Lbj+RUMjTV7L+A15wKC3XRNcRUhwyMhIQqhDQXO9+6kIkDNnxwO/GV0Uav3/nX/rDL7dx5s4aEo9hzDrsN1d4ssjRnj6MptYvtgHBNdpGU7MCAWjdN986FyZiOQ/LOXrR44Fcj33aEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJXHDhKkp1SXzrIRDksbhwRvm+I4EKvPMFiMnkFx/LU=;
 b=Xd4/0SiBX6Ws1rP+YSLNhySRMhFY95ws+JVFWRK7L2XndknfWtU+jFW1IEJmI8uS3XxONkU5vuHECQavhbC87/OO0d3HnBgBA3pFpuznN2kRA0a1KCw9IumKPI1vCtZ4ewFyNX4UVZzGzkevP5+74Agzdq+GCJdrOGxoTqunsWY=
Received: from DM4PR21MB3539.namprd21.prod.outlook.com (2603:10b6:8:a1::22) by
 SA0PR21MB1963.namprd21.prod.outlook.com (2603:10b6:806:ef::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.1; Thu, 29 Sep 2022 22:02:47 +0000
Received: from DM4PR21MB3539.namprd21.prod.outlook.com
 ([fe80::ea20:c0f7:415e:cfd2]) by DM4PR21MB3539.namprd21.prod.outlook.com
 ([fe80::ea20:c0f7:415e:cfd2%4]) with mapi id 15.20.5709.001; Thu, 29 Sep 2022
 22:02:47 +0000
From:   Stephen Hemminger <sthemmin@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Gaurav Kohli <gauravkohli@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH net] hv_netvsc: Fix race between VF offering and VF
 association message from host
Thread-Topic: [PATCH net] hv_netvsc: Fix race between VF offering and VF
 association message from host
Thread-Index: AQHY00EEonDO2Eqw9UenXeZDD8gM3K324LIAgAAIDpCAAAblgIAACChg
Date:   Thu, 29 Sep 2022 22:02:47 +0000
Message-ID: <DM4PR21MB3539088038AA08ED755EB67DCC579@DM4PR21MB3539.namprd21.prod.outlook.com>
References: <1664372913-26140-1-git-send-email-gauravkohli@linux.microsoft.com>
 <BL1PR21MB3113EF290DA5CE84A350D6BDCA579@BL1PR21MB3113.namprd21.prod.outlook.com>
 <DM4PR21MB3539D38A74B62AFD95989581CC579@DM4PR21MB3539.namprd21.prod.outlook.com>
 <BL1PR21MB311302D81AE4F95061D60FCACA579@BL1PR21MB3113.namprd21.prod.outlook.com>
In-Reply-To: <BL1PR21MB311302D81AE4F95061D60FCACA579@BL1PR21MB3113.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1ac951a9-e996-447e-b217-58dd1163c49e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-29T20:35:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3539:EE_|SA0PR21MB1963:EE_
x-ms-office365-filtering-correlation-id: c2a003aa-7361-4bda-2eb8-08daa2665813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QQjHJLVh5XnYbMWvJSga9CzhZQBxz+2wSJQ6S70ZBNu+fyXrZPMlX3YU53RZBkSPu5iR9mlNy5cyBXahlyLQCVQi0YZOlU33O7wv3SI+QMpz1NAv6FHQuw8OcFYVMEPHq8qc7RKdM2JpcRtAfma1deFhnV++vFiLry0UmZXnbjdmr+jO49dQa1giXJZ+2ppEyWZN3zEZQaT5Ar6iKrCiM8KqMqwb7trFEF4wk8qLp/05cWcJ/ZxdqXNhHiPcTQ7/XYHCQFGchr6amITHqIEQxhlpW3S5lQdMmT297jvlL4LURh0bEJDIppQtaVFoaSuMA8BBJgQmQLJRd0PLbTSOcv/hoNsIS0oDM4WkTuiTykudDfghAO1QSSgAKhEXEZ64Ox3cuAlUBFu3OUDX3fvxZDorT3TemYuWB+nYtpyyjMCg0bNBqmS6pQVcJ3vzgGw3qaboukDpvUHtHPYJosIPcKdg4w9qrT0IdEyp036UNoqzq82cExqlv7WYLox1uqUOF/lwKJvFCrBuQjM8uwJ+vmHTqx7WJp8VwkhjO4XeW/+hz68ZJvIG12ss8k2Aar9ZlOEz1T0fAqvzk9NL20AwMxAvdH4wlxrG1cSff9aolGGQJ+Gti0X2NVPW0PENQjezPDI9anZT7MezMO7K7647Wa+Hg/Ukw0i7SPF3kOmObpzmxZ58Euc7MiHjfGHdL0TLC9Fvzxh1Zn50a2OA72cTrVpCaRrmIpzsIm7BLp3q1f2QYAer//HDfbjTLWEMyDNQBwS1D4QeJYrFfB9tBJ42xcyZ5WxdW08cmiQ2TexHTDNxs0NzkmakJMk06BK8eWk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3539.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(83380400001)(2906002)(15650500001)(82960400001)(82950400001)(41300700001)(316002)(38100700002)(7696005)(6506007)(55016003)(38070700005)(10290500003)(110136005)(86362001)(66556008)(76116006)(8990500004)(66946007)(186003)(478600001)(66476007)(66446008)(64756008)(8676002)(26005)(9686003)(53546011)(33656002)(71200400001)(5660300002)(66899015)(4744005)(52536014)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mmhtnf5hg1Pq6/+3r8LwfyUTy7YOkWi0RK69MNzvZhfTljRAdesVFfpDH4Vz?=
 =?us-ascii?Q?P7rdhNneEnY0cTx/1pomiFqWtFR15I/1YNYKQfYXxScsp5YUn/OEwQO6/qSx?=
 =?us-ascii?Q?Qn62eqXEmBlgLYu3RNQyTICTAvEx7aQEf0MIgiwX2Ugxgyrhd45EZP3aosxq?=
 =?us-ascii?Q?NOkGh/c3P5n1O6eXcOiMEZzCjj+ib38IhxTFt12jYdb7NKT628EnbNqXMpJU?=
 =?us-ascii?Q?Zd6LOcmY6+3eqU5ZnctBwW7TV8ojsRHyfOeNxNs3i1ZX65vGLDWPQNQNDA9R?=
 =?us-ascii?Q?v3wLcZ8XVQnxVxq1GwwwXFYPpf0dqQxsjaNmX1lBkzFzpgWE5d2Ubmku3E9O?=
 =?us-ascii?Q?8G/TozfW7YPtvdCzNbiC1oIEjvnGuJWA8EgWf/9hacX5lEambQwZBStSaDgP?=
 =?us-ascii?Q?G9JI3W3GDD3V88YIC4G5tovLqyFpyejyzAlQJjGrgN1iOTL42mQBu791AZ8X?=
 =?us-ascii?Q?+RZ6krvSQTMGvF4yKrYT2d7iMXnUpz+NooJ9uyxTCoILtSbKVw60878U6+q2?=
 =?us-ascii?Q?ZgLID/2xRIgLLTzZoR3GIZNorA6gIYmvznK19LPjeaKehvd+gStBvpmPerRM?=
 =?us-ascii?Q?cb8H9ItCqa8DpFykPvMOFIeiRPMxAnLzaoA1Jidlva6r3oRFX3TgmWqVIsYC?=
 =?us-ascii?Q?6BYgC7bsKPydcM/I+IEmUy2fAD3sJmjWpMGLaJhXcxmDLAwcvsIItYixHOxG?=
 =?us-ascii?Q?sI1wmGSrF4I8ljV30Luglrl63BKmt2bWeRqc2dlVVw++IcI5hv8Aht3VL9F1?=
 =?us-ascii?Q?ofij61xz+JCtBArAPwYlNoiMg45oxJNTOlsnzdDDX10sOahCsbXV5DtEy6eJ?=
 =?us-ascii?Q?5YpoO6yMijV4bOEwzSOIXef3qY44vMitA4uL6QUQcPndUHFeh4FB64Iv4xKw?=
 =?us-ascii?Q?cu7G3qFnEx6NbMbS+12UkYXHQiVXvjsIOemTjjr7GPLZHbLcqbhrbRDE9fzg?=
 =?us-ascii?Q?oQPw5jQmonKAI0lUKSuwt972EKpnGeDrzz10aSb2bIV2ziLXoZ+m2pss/s/z?=
 =?us-ascii?Q?uyFy8pskcUM+GUDCDY65To8hZFxeDKDFvTe/ZQWchB6Jv4imMcuUwr3mNJEw?=
 =?us-ascii?Q?P4O5rRrV5R0WGUAcx8TQ8NPbeNb8hqHOTiS8fx9lA8CPFOhKji3jARSYpKho?=
 =?us-ascii?Q?No4XL0yRW8MwP6KOmENTNciL0VDs3r5XVjO/GmSxJJr4W0uTvXPdUUhNgqp+?=
 =?us-ascii?Q?o65atNMvwwoVo1nHe4GhgL5aB4Cpy9pjs/eIePzOewQTHZnaXr56SoZsz8M5?=
 =?us-ascii?Q?SiFjNwKxyMXsoFHmx15UH74VdLF3B5CDc7hLaWipzHx2PfDL6AmWgmvC5+cw?=
 =?us-ascii?Q?fjh853cEqIrTVOIL303nS1aWFIPp+0Wg2LcbdhpYuhjnNHsWZjcLnHd6Ft9e?=
 =?us-ascii?Q?dSnxV5HSSjEViyhlQtLd7rG8nt6kcRtdJUgz+VLaU5wlawuj2Ef/V7VWIWNl?=
 =?us-ascii?Q?lHxJrATDVXqegHRddi2CirmsPOUKwbEjWGtpmW8RZrFtMPhYZS3hnPtj456Z?=
 =?us-ascii?Q?lYBqT04HS9JPI0+hkRWCmeVjL/Fuvyojh9VbyY/h691ANTYgMv8tNze8wCaC?=
 =?us-ascii?Q?wlxXwW18xU6hsfQXUwqGdNSAunJ88YGRBfD3gFIc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3539.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a003aa-7361-4bda-2eb8-08daa2665813
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 22:02:47.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFXIPYw/IEjuVPSjd0vZYijzp9meXsb6I/Z+t2veHlGybUbKn70IuDz99aYoJ5kSB7norSYUsI7REzCd2t6Mow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1963
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I would add a comment to the commit message after the --- break

-----Original Message-----
From: Haiyang Zhang <haiyangz@microsoft.com>=20
Sent: Thursday, September 29, 2022 2:33 PM
To: Stephen Hemminger <sthemmin@microsoft.com>; Gaurav Kohli <gauravkohli@l=
inux.microsoft.com>; KY Srinivasan <kys@microsoft.com>; wei.liu@kernel.org;=
 Dexuan Cui <decui@microsoft.com>; linux-hyperv@vger.kernel.org
Subject: RE: [PATCH net] hv_netvsc: Fix race between VF offering and VF ass=
ociation message from host



> -----Original Message-----
> From: Stephen Hemminger <sthemmin@microsoft.com>
> Sent: Thursday, September 29, 2022 5:10 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; Gaurav Kohli
> <gauravkohli@linux.microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; linux-
> hyperv@vger.kernel.org
> Subject: RE: [PATCH net] hv_netvsc: Fix race between VF offering and VF
> association message from host
>=20
> The policy of network development is to not copy the stable list. Instead=
 the
> netdev maintainers want to curate the patches going to stable.

Thanks for the info.
How do we indicate if a patch to netdev list should be applied to stable tr=
ees too?

Thanks,
- Haiyang
