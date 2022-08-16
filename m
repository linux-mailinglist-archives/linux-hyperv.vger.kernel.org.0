Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C667B59645F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiHPVOV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Aug 2022 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiHPVOU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 17:14:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB965813;
        Tue, 16 Aug 2022 14:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0RmcgnDtgC0oAG3ErGskLyc98csynEdRlvz7GvkI7ZtWKXdEYPrxePkDtYRiE4EZFHOWXVtdA+/RGJUUGDEIKBKadH2+O7AVHyW2Jeq36VprqX0oaLYegFVI39dcOzaVX3CQD7eO6noelIDiProNVJ2/bp+2E6n3WKfyr6CSebNp66RUr/lWZt1WG47S4XnnDSxy+cfsrhNydSUVx9aNsXuP5+HexDGhfVDkWVsi2GRJtXM1kgUo9EGPlRT47uhAvJMMxsRWkzIp2L0jl5TF9v+zr1EM436UarnFCPjTGELQLR78TsJB4Lhy1IUW7Wh7YhlIUiZNxhROtckk9KyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v+lto6jB16Ll6F44Xj8PqHDVaHzWWyI93pqJN7nnvI=;
 b=Z4kXjmBBxX2Y/Cpp7oLt+hiT/KXNunbx2p3JFWvbL+5l9Z2XNNUgnhRQ1cd/J9TK6TA5189KNPWO5FDPQjMuG1KRne537CQQ5WHuLjtl7pmmOEvWgathtDRrEyIi/Cxwcrnrt4UGDXrECZ1KQQcjePJqYeETtiLZ0UMC6qxoowkOsjKS0c5XMz0qqqJOO9P3ZhGP0uxT1DBih8iaNLLhY2qCDE9RAREZlaX/v+xM4xmvgPP6x6PhJ1M73dj2mGRQd2ocMGMCEd2o03COWkO2mlzNoow9+gvsMKVEuRvs9IBTlO81x/kAzaBfeBFFbphdGUxpWY8UAVOxvQHKx16L6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v+lto6jB16Ll6F44Xj8PqHDVaHzWWyI93pqJN7nnvI=;
 b=NarRa2Sy7fTGK6G5VvJ3DlBfXFoCHNCI2eg2cns/lPXds10vT9d/XqnUHiLZr/Xli/k+P1bwpzXf4J8poD1ZI0Z8j1tW/Ge1Q5Tz1KbkbnNO/R0qM3eFJkWVr5/4vJn8pVntX6pAYI+dBBDZBtM4OAVA85duh46nj8uG10RA0oQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3339.namprd21.prod.outlook.com (2603:10b6:208:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Tue, 16 Aug
 2022 21:14:17 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208%4]) with mapi id 15.20.5566.004; Tue, 16 Aug 2022
 21:14:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
CC:     Carl Vanderlip <quic_carlv@quicinc.com>
Subject: RE: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Thread-Index: AQHYsYlx2fMcX0s9O0OiWaZVRKUYJK2xtktg
Date:   Tue, 16 Aug 2022 21:14:17 +0000
Message-ID: <SA1PR21MB1335CDC53B8B4B03838CD335BF6B9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20220815185505.7626-1-decui@microsoft.com>
 <5e4258b6-d253-c8bc-f697-c21d7eff63a5@quicinc.com>
In-Reply-To: <5e4258b6-d253-c8bc-f697-c21d7eff63a5@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=65852d3d-c2ca-4201-88c1-7b33cc3ff44c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-16T16:24:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6faeb158-7e69-41e2-ac45-08da7fcc4784
x-ms-traffictypediagnostic: MN0PR21MB3339:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: laWjOoIfTczfd/qTGD3inlk2FErtQaihOfvrBvicn3ObwShSNeLjsH4LBWzXB1s1dpfQUFxzj5BPm8LwDRnPnnZZjyUOMSQP4YK/b1RA05oHB/1r+TW+7ocooyRBXcGHa4CxFTRpdznG/7yFSh43oh04cHxkpus+HVd3saGh5r+u0Y0ilVBA7JqcwniInTVkdpGAJszdAOc4OrI9ppnsAYVvAnonH7Z2eDMI1ku/0qVg/U2fcy9AEgTfF0FxTOw8tmR36U00dpeSDld92U29qsdXcPknNaxsaD9514eBScon6y1hEI89+HT2CoY+NdtowVvknLYPEAksk8ak1EDqXULAfc9PPhM3BFDhdW4+MUI35KxUbMq/NiC2jSkjAZDylOLySQqFS8r3tYXvbYsUrNunylfC9ixRWs6TtO5I30sClJ3Du/lkzR2Le/SYbdJrNiGcykS/ciXmVf7sLgoyL0fcsr1HCoC9c4sKKGSrRSwNDtvz64bpP6qT9KVXfCO8FpdPIGZR1NzBEEDvYQexmkym4FGslneGXpFjvi00Z2eRfH8+rt8C3YPP7Z6+NdV6fbQT7Cs5EgwE4ZplwHzIpf2tmMULLGsh6itdzJhZ5L2pGf8m2dY2LROOpheWW2NYmtCftVcWVm1x7/jaSTYXMEIiEUezD6AgDq/6m+5KqDCeNxutuR6j0TNyiT2zN3RfcNoAmL0SnCb+sP1EkrPECThiwvpCcf8eXVjjbJTllJOP0c1o8Ff3sJaPmXmjbYZPFrewx1kDsqlskEcXUYUSPupCAOgQoWNoaFcpwov+r7TXwpqkDO6iEnZu24PwlPqvMKvHR6isHrjw6fTO/jM26L+LKPHYg13IFSgv5bhx1fhZef0jjE02WR2YS4RlOftg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199009)(38070700005)(86362001)(122000001)(921005)(38100700002)(478600001)(82950400001)(82960400001)(76116006)(4326008)(66446008)(66946007)(5660300002)(64756008)(8676002)(66476007)(8936002)(7416002)(66556008)(52536014)(110136005)(33656002)(10290500003)(6636002)(71200400001)(316002)(186003)(55016003)(83380400001)(6506007)(7696005)(2906002)(41300700001)(26005)(9686003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSrJBIstmsCzAeUu0LQnZuhgQDAWwq9cKppbjWDMjpqiIJfriMomrxhgB2yn?=
 =?us-ascii?Q?KJXxBL8xzkwyKeFW9CFeyQYRfs7SR/0qlUyZ4/4XTpWBvpAHXYTQNpvYYjBh?=
 =?us-ascii?Q?No8fm+Fixc4xMgu9qVSV7sJwD1BjLQIpc9fmc5KC1Nv7k3jTQHoSgikSAprJ?=
 =?us-ascii?Q?UKSObgFFRl9OTDrSP/HWpZ5o5ak2V3F8t216UO9A6WVHGE6Db209DQey1To0?=
 =?us-ascii?Q?Krw2UP5O3OO3V+vmGBx5fAj952RjT7QyXcbXTt96YYYQtb9dHSa/zCsocyo2?=
 =?us-ascii?Q?N55L17onR1HY07Pg+HaDv4dzcf2rURelcuwNxp65Q2f6fnGMKpyuBmn5Hn95?=
 =?us-ascii?Q?2vt6Byo2yJCChaiuRNFf87WXLhLPwlzf8tyA2mNCG+tRyU25vekXV8AmEiQ5?=
 =?us-ascii?Q?T1xpjFc72LrTQottQ4AjqqSm+39pGBZyEZuk+ZeqzOdaSDROT1TColXLKZTE?=
 =?us-ascii?Q?KQ8tZND24ywqnk4FT4czLkRSKH/5YB7+mgoG42mVsfeXiHG+NunOgbkZcSp4?=
 =?us-ascii?Q?yGbK3GVSHUv8+6TBcCZqb7pvANR3iieEDT83i3WEY6ARws8mlyCpuVTdyjXy?=
 =?us-ascii?Q?ukUrxNiOBi0ylJLYUrdsPxmo77B9KM3XKVvjZIZXmhiCEZKYH10gSAEvorVa?=
 =?us-ascii?Q?AsyW6Jt3xgQyDGsCTSpYvFkxKDb1jA7P3//r4nZA5j1V+lxZkDTq8rHJqq3s?=
 =?us-ascii?Q?mZPaotq/CdNrqIOr1rZUr5cU88O3EFo5MLM/qQ0hd5pCvP+tCsB+kXdMWYWJ?=
 =?us-ascii?Q?ZwE+vaayaAunbE2Hpk+G4X6N88ZzfeS+uKbvuXDmiwejtF+PDsLUofRdFw+f?=
 =?us-ascii?Q?J/TzQxrlwyoCoiHOiyTHAeX/nnzCBL39FJv0vEL6P6Dktf8ARfECc5mYcOMP?=
 =?us-ascii?Q?Uq8q+bwdJekdk6iGp7k2o1OStwpCgiVpDBIynX7tk+Sw+nPW4cGiFIhUiEf9?=
 =?us-ascii?Q?FmoT/uy6N+2ElZnR8rFrDbnDHQen0NXevOy7n+Q+Kd7U3ngGdt1Q1eXTvosl?=
 =?us-ascii?Q?l2sQr4sw8dJ2VO5yjGsEP9vNxxgLLDopZrqH619gOa+028uic5e/Jk3tNIa1?=
 =?us-ascii?Q?iUMIkrsK44NNxcI3/6y+n1UGUe4OQoELnau51uEUf+UovEacFrFRwLXUvRin?=
 =?us-ascii?Q?Pw6EVE+4Ygknx46VitOMLuYawtY3Mu7KA3s2zSngfSSRnbdxshxPLCQFpUlh?=
 =?us-ascii?Q?69/IZCqcnKR2slSjlUSwO/jky4ppPBbztxZMM0+ZgyyluYSVBTR9F+LtyL7H?=
 =?us-ascii?Q?XRSIVGi22Tc4WNpWBcuFUa4klJrvZm2flO9JdCB423f8zWoSFwUXVIDwDCMp?=
 =?us-ascii?Q?pNwmz7yoENXwjCV1HeBvw/YGxwND2jkh4J5n1FCwvNuGhN6OMVMzmtrZV37C?=
 =?us-ascii?Q?RdQTIeM9LIIHKopN6jYODX1Q07VOS2cYgbL4IEBvPgWRLq/YWCFGJWj3pRIf?=
 =?us-ascii?Q?wDaHZKhFYQqZr9aVQEOSzxe253rFfhnI7eVFMeO6H55DXDqwdplTDmC226Kn?=
 =?us-ascii?Q?E8eaJMISb7J8fE0jREGTS6sT5V3T9mIQOUAIcjTgOkR5vDChgNpUrj5ZkAe0?=
 =?us-ascii?Q?Tq90g3acsemOmAIZAWHEhgZ/jiX0wQdTZiUkxLZc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3339
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Sent: Tuesday, August 16, 2022 9:01 AM
> > ...
> > @@ -1702,7 +1702,8 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
> >   	struct tran_int_desc *int_desc;
> >   	struct msi_desc *msi_desc;
> >   	bool multi_msi;
> > -	u8 vector, vector_count;
> > +	u32 vector; /* Must be u32: see the struct hv_msi_desc3 */
>=20
> Don't you need to cast this down to a u8 for v1 and v2?
> Feels like this should be generating a compiler warning...

My gcc 9.4.0 didn't generate a warning.

hv_compose_msi_req_v3() is for both ARM64 and x86. In the case of ARM64
the 'vector' can be a u32 integer according to the comment around struct=20
hv_msi_desc3.

hv_compose_msi_req_v1 and v2 are for x86 only, and the 'vector' can't be
longer than u8. I can post a v2 with the extra changes below:


diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 53580899c859..c7fd76bc8b4c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1703,7 +1703,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
        struct msi_desc *msi_desc;
        bool multi_msi;
        u32 vector; /* Must be u32: see the struct hv_msi_desc3 */
-       u16 vector_count;
+       u16 vector_count; /* see hv_msi_desc, hv_msi_desc2 and hv_msi_desc3=
 */
        struct {
                struct pci_packet pci_pkt;
                union {
@@ -1788,12 +1788,17 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
        ctxt.pci_pkt.completion_func =3D hv_pci_compose_compl;
        ctxt.pci_pkt.compl_ctxt =3D &comp;

+       /*
+        * hv_compose_msi_req_v1 and v2 are for x86 only, meaning 'vector'
+        * can't be longer than u8. Cast 'vector' down to u8 explicitly for
+        * better readability.
+        */
        switch (hbus->protocol_version) {
        case PCI_PROTOCOL_VERSION_1_1:
                size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
                                        dest,
                                        hpdev->desc.win_slot.slot,
-                                       vector,
+                                       (u8)vector,
                                        vector_count);
                break;

@@ -1802,7 +1807,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
                size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
                                        dest,
                                        hpdev->desc.win_slot.slot,
-                                       vector,
+                                       (u8)vector,
                                        vector_count);
                break;


Thanks,
-- Dexuan
