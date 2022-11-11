Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037E362545D
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 08:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKHRZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 02:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKKHRY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 02:17:24 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022016.outbound.protection.outlook.com [40.93.200.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD979D0A;
        Thu, 10 Nov 2022 23:17:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awuLX5RbbgYWmCV0N774FrtXcxe4ciLcVABhia51KdtoFmuhgeFHEx2GcIMVt3l+Knea6x9Sz8tGQPMo1Y3YxmYJtcoWE30mSnEAyFvAuo9Lrktu7YeTAGOg9bnllW8vlwqMktDLPkz/TRmWj139F4VfmktkqvJ1PcrgGv7WiNbpdcp/TPjfsGREmkiA8N44xGaDfqqbr4iRWUfgeNvWRgeXnxYOSlwSvAo/aWoqymaDw/eqPTyfPdM+o0k4gSLeXZ1ix+s2LFM0nPBREZ7wCSaenWxHLbaQNHsmZBcTnjFmUcXPA9R9ZsTHY69BRs/WXFT5qNzDjt35Y6nOibMSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dyuJgfAU5AKkhpd0GMgko026rrf1+5TFe+tOn3AnKE=;
 b=lTVZhd97r+2WuTFf+Wgb30MJaMBO4ROGYtSFDJKnvciQZaLAANtcCIqWPSZidYUINME9HSGlbjw/5rKJxdM2z9Vdk7gsW+oO1tq67oAtuHFrFE1CoQI1U+jHLxB/f2g0WOCbMNkwvludsw9gs3fFUQJgprLADrbRbbKrGQ5BRt8mITsDR9MJnGKf0mxKDf3FE2DeW+Ec/w0hqNaeOxiBEAfbJnT5JHD7Z9lOsq+K+MuAkXddjOe/VaXtRlVrcObYja4SDFp1BD2CPbzw9Jo3ItcvX7PewxOPJUWEUpo06uNNaek0MiEOgp9fw7rJYX+kagt5DM8MEmQlQq1H/+o2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dyuJgfAU5AKkhpd0GMgko026rrf1+5TFe+tOn3AnKE=;
 b=D1Aqdmv0nQyTTCbCLEEFdYNpj+1qyXVVLASX1EFnsvZbBPrWY7PTqg9+p5/uX5EXg3u0X55AD8R1Y2J/24lfMchzd/h2XGzByQ9Rw+rDUj6QZJJiGthYvEykNHUnNR4z8voQ05MwTjlDODy5btPuYrgfO3HLKgemo4FOQ/6KhLI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1935.namprd21.prod.outlook.com (2603:10b6:a03:295::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Fri, 11 Nov
 2022 07:17:21 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5834.002; Fri, 11 Nov 2022
 07:17:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "quic_carlv@quicinc.com" <quic_carlv@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHY9U2HlQKzFek9kkuOCBwYhpuQEq45T4hA
Date:   Fri, 11 Nov 2022 07:17:21 +0000
Message-ID: <SA1PR21MB1335FC9D3380B032E6A9E975BF009@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221104222953.11356-1-decui@microsoft.com>
 <20221110214354.GA674181@bhelgaas>
In-Reply-To: <20221110214354.GA674181@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=33b948f6-3522-4a7b-84dd-4c8973b38d44;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-11T07:13:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1935:EE_
x-ms-office365-filtering-correlation-id: 514f65ca-e00c-4235-ed82-08dac3b4c62d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5qnkK2bFL1tYyhIS6CdHD4Lg8FF4j6ZC91hLhgkDgvRUxE0oWpq1+73kp+0GBd+CdmGa8O4/m/6oE30d/jcCLAbJBtsyCxDkKDESuyy+7Uiw9Pn46gn011417HyT89xFDNYEwxZHHEA4SBy6ndDdoTpnjCxtdGbXjo3XE4pfPWHpCW/mFtXQciHQ6nQaYd3evLElhsXnxn7znE5zCEpb+U5rBgAh5TcTjm94DKtdHiykNRx6kny+FcyHztw9W/suec1u7LcGn6MCjGwiGTAGTqQjVlZvcR/3VKv691XxT9//yTKKbGpEDFcmBW6pkfVs7P6Y3ajUPH5tloBuF1zMeUibDuE+EQB3LuItNLlY2iXbGEMsncJI8p87bKrzTarC9UN5a563ULOVjUlsBULt3QznESgNUx1e/8gJjbFKPdcb1bsTCjflGfygDJfPVj23HdVEusyoIXXPD/3OpVDw1hMgSvBsLR4hZbxfiieJiqpVIL6HGD2aBlGxClWO0SQK3aNzF7NgyMNxoBdJVL69mvuy5zn2rG6UCXojosYdLgB1g5PHOh1zBifQnPdb5oJ+x/E7xpugH91fNNThda/47/2q8cr8iHZTQTGSAemtO2z6rVfhNJH6WwXkDD8zDrchZY71V7p6VJmZPbSxphuq2Dr+ICyoYSF76Ci1oHrtCcgvwfwTPZJ7PlGcn/Bk+HGF/aIJV1wqhqB+VEDgeoY+a++cg10/m0E0BDCbhuLfptg7yUaaUFVRX5mZ3Q0jDn6bXApvs3Ww8KbkfA5wqSHr1AWLzc2ZThoq28pme3AZWIJbROsDp3HeRqEGHC/CYVkZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(82960400001)(38070700005)(82950400001)(122000001)(38100700002)(54906003)(55016003)(10290500003)(86362001)(110136005)(33656002)(316002)(71200400001)(8990500004)(5660300002)(66946007)(107886003)(478600001)(4744005)(66476007)(52536014)(66446008)(41300700001)(7696005)(7416002)(76116006)(8676002)(66556008)(4326008)(2906002)(64756008)(8936002)(26005)(9686003)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L/jWFDntRjGCMeS91sZg7Het06SEP/Fcp5bwS8gjmr2BaQvuHkb/apLTvotB?=
 =?us-ascii?Q?Co3iGGVN9tzg02/Z/iQPbYbdxlrxh7eR21t7zFZtAOuSuv7JqQkvpryxbp65?=
 =?us-ascii?Q?sjuLIckXcyaXKdB4Q5plpe1wgo1vkeOID5aTLVtqtsiyRtVeTu8BIUH5/+es?=
 =?us-ascii?Q?I0R3K1NrLVl+9kkJsNwhNGR9CM6QLlYxmX0UvOaBSloN0kgrRFw/OAp2lfD0?=
 =?us-ascii?Q?/Shv7qr60o3b8FIw7vjQ/+8ewSeXrzCJZJ/aE1UjOFdqQ1mckKatEnm63p73?=
 =?us-ascii?Q?lNydhQ8PRYGqw6af2eAhv9IzIW0l292nWaZZLxPT290W4UrA0UJDyNPAZ1kO?=
 =?us-ascii?Q?jvtrzfnCGJ7PBErjgjy1QPy44Fr1ohwhbV/m1iHdIdH6MND4YoNGq9trSSJx?=
 =?us-ascii?Q?qhTRjpidbiqYnhwM4b/w94AxZkE0ZNVPL2rNrSCXRG662a4egKq1FoDOdTDQ?=
 =?us-ascii?Q?tFJOnvO38vwOBaGLNulRBlot/mZRmUu6g7FVRVjju+sI8XMdldVvQL6+FpXc?=
 =?us-ascii?Q?kDBhxoSFLzGiuKVP3JjOXfU07FEqlHVx6DrxnVUi5QNQcVK2oH2/nC9Ta+P7?=
 =?us-ascii?Q?lTUPKQ7ZBJsfMSthAdlrR/RbJr/hnv8TsRi2jvlUaUuQbEWXtuERZLQ/moHu?=
 =?us-ascii?Q?b/3b6h3rjJ5OYgJwb606p+c9ve2NRS2V8WdJ92pTr8uehW64CN56hsr8tvbX?=
 =?us-ascii?Q?hvMYrcaB1xtm5w8ZJa74lCTMtj6ICx8yeCqhhs5aSaa6IDDasWGG2nji316t?=
 =?us-ascii?Q?G0u+FSBheTBF7kopFhr0EKfNzWAY0Z6cGrdA+Ht1ny+mNZJLboexmtmUhH+Q?=
 =?us-ascii?Q?5kEG1QyXDqriIe5lHe5gPR77sd2RD6JkV2MMfagQk+HwuHOpDCBizvkwARIH?=
 =?us-ascii?Q?393Ro3mvWM/sbpA2FctjZctXxVIUVslj4Xg2RC8Vy51p81MqkemcP7qT7dJQ?=
 =?us-ascii?Q?427WmD8ORAQWJCwAL+bWzDWfhR4LFEVWWa2SfnSd0GL8FG3N8sl2veU9jYM6?=
 =?us-ascii?Q?MEUwEFVl4IwpZ01hIyiXuibQ1+dDwKSjDGkSt6gdKgB+FhYDnGo9y8MllIcQ?=
 =?us-ascii?Q?rdxTQr1Zd7Gb9/f4a5LUZAFaUXsPjmfHDn2N9TCRpaIM+hZrxLW5Bt5QBTx0?=
 =?us-ascii?Q?bPyyhR9nlaoiICDfHVPMPvArK6NNZFntCJ535ToUMaWg9ignxadaJPVGVc/H?=
 =?us-ascii?Q?AtFP64QHfp020Z6X3IkL9q8/667yHH8kEkPNc8vjAo82PXwbRMOE4xTQLqmo?=
 =?us-ascii?Q?5UlVD1ruHR0Ykd5FnCjxsoQqtZZz6UOWCdT6h/80oAf4HDxBJMYetKpXY86G?=
 =?us-ascii?Q?kDAdKH+0AeVqHLjQT2TrAJLI2q37Ng1gzxnIRut9quuNeJTHXk2/PFjIaid8?=
 =?us-ascii?Q?h8K0+XDA5yvB9y/dHJ/P8z15EwcmUdYmmR5tFj93NZK/MfyIEghXiFJHHpGP?=
 =?us-ascii?Q?aD0b5g4gRsRVQV/H16TLDA8xlzxZvukjFbBK25ATirkLan57Df6wOUqCk6jP?=
 =?us-ascii?Q?qRM+G5Mt3AVl/BY1TUS5PiY8AHnuAgXtqO7gIqi/NUPJBo2fJOguy2bqD7pe?=
 =?us-ascii?Q?VVGzTH86IceET6Km4jSCv9IfyLSLlUvUnmq383Tb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514f65ca-e00c-4235-ed82-08dac3b4c62d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 07:17:21.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBRW6o6FRXUyD1MQvT0T1AauKU6hX8facxYErPX00/T+J+6Qo2kfrEQirFTBpsqKQmXA8pR7ZO8cyhYlww0Oeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1935
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, November 10, 2022 1:44 PM
> > ...
> > Note: before b4b77778ecc5, the pCPU is determined twice, and when the
> >  pCPU is determinted the second time, the vCPU in the effective affinit=
y
> > mask is
>=20
> s/determinted/determined/

Thanks, Bjorn! I suppose Wei can help fix this :-)

> > The hypercall fix may not be backported to all old versions of Hyper-V,=
 so
> > we want to have this guest side change for ever (or at least till we're=
 sure
>=20
> s/for ever/forever/
ditto.

> > Bjorn, Lorenzo, it would be great to have your Ack. The patch needs to =
go
> > through the Hyper-V tree because it's rebased to another hv_pci patch
> > (which only exists in the Hyper-V tree for now):
> >       e70af8d040d2 ("PCI: hv: Fix the definition of vector in
> > hv_compose_msi_msg()")
>=20
> Fine with me, but it's Lorenzo's area so I don't want to preemptively
> ack it.

Thanks. Hopefully Lorenzo can take a look soon.
