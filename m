Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93935512067
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Apr 2022 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiD0RO6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Apr 2022 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiD0RO5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Apr 2022 13:14:57 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52192424AC;
        Wed, 27 Apr 2022 10:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTRylH5VXQwwEsmBPTNrRdgaSy31vWSw07yl4J1wq4frybqNDxzXEvr5kRsdyhTYK9XW0XZ7blC/ai+ZtUv9oKBsp3js1FXKSH06jgtaRUUNxDQujQTBaVY69GIncAXlVLgQVNpZoBL3ydsEq/N/SnGcTM4R5Hsl0Cc8zSmtbJ+eentSUTu+kWXFTWFNmh2ef8bDG1/5/nPnRLO7Bq1LLEijU1xNr9UJ5ckMRdv28cLj/xdGVJr0zE7eydMuV1uOi9Yh7pXRXTnAyn/2RUgUu0EqhYz/0LFI4QtfsMvyFmw/sZhya/SNLytFDSa/xXB7JTquJf769TUvOG9IkoJRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozd8pjXfaoCZxjyOB0IwWIV7iyEj994q/Awoytb5huQ=;
 b=iZP/BkxNh7XMt+XCOcU0jD1D/04LuTgfeDRSEDdcKZ8vGVqAN15Hw5MkW0bXU8Xdle9vTDQnN9blHB07nNYhOl9lo5aMd1hQqSZR/DSbsv4yILX6bQgv7uWMaZLEBHlhLz8kTLdei2jX5vlV79dHZcFI7HXJ6iKL5yVvAytpKO3Qw7uODio5pvFPA0HVl3asRn9ckJF6UWrqThmhxp4LbfCt8qPfAF3z7ykv0ofLBG0WvNEXMQhhLlHHFH0GpxG0/OE0y9lTlTD9l4MZ0ZJ6Dguxawxje2sZ/tYdyRXVCjEkgH9ZdlPCmaMdF0/m0yuXC5TmiIgPh1z0N/0o+TQtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozd8pjXfaoCZxjyOB0IwWIV7iyEj994q/Awoytb5huQ=;
 b=hWbrdruoPTibT6au9ApskpVfnDTFtYM3w7fyx5O/MUwMsHbSywDmfTTIxU4gZoXp/2GW0QwHQruDtFuMXIzuUICSsbhqEzVwAnWailLq8zztvXgB+pI4e9brAocanCOFeZZEvYbzaTgdS78A9HOSUDiTLt15Mmw7VWAMWMqZNz0=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1372.namprd21.prod.outlook.com (2603:10b6:5:16e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6; Wed, 27 Apr
 2022 17:11:39 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%6]) with mapi id 15.20.5227.006; Wed, 27 Apr 2022
 17:11:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
Thread-Topic: [PATCH] PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
Thread-Index: AQHYWkCLItunHPw0GEyDVf3jcez6pa0D/dPQ
Date:   Wed, 27 Apr 2022 17:11:39 +0000
Message-ID: <PH0PR21MB3025DB8EAB4714E059CAC326D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5ce671b0-15ed-4848-b89f-4e90f4dd17a2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-27T17:06:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd5bb9f5-df25-4012-91bb-08da2870fe7f
x-ms-traffictypediagnostic: DM6PR21MB1372:EE_
x-microsoft-antispam-prvs: <DM6PR21MB1372D8C6F05BD5987CF8AA18D7FA9@DM6PR21MB1372.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sdeZWveRQ+16svLlYMpeQUpOeRqPeYWRPajQ5O/cngLKX1y+DtgKOqbELgrhmqL5kAhANJ5eXQcmAE8q5VFMzhF3TYzM62VUlhB+8+u2XrBPtCXe1ZeT1v7KD6gF3wNKgOl993F3brgNcg5Ec5ckO8FHJpXMib+MnS8xDKmFHmOO6W5iIAYOhkkj0iNJ1/ESdg2YOXlFY3dkzJv31quMF3RgUm02m1C3Vgrq8YKP0vfWRM8KlRIV85ydvBf72u3PdbG6o3DfSNxeQYf9JmovUFLrb6cXQT4+dB83DvdJhf0k53Ut2eWVbMxJ+E2tL+2Otb21ursuLl4fZcJtwk03fC1tRi1UQLI1RH3YtaQOlbrOGY11QmfuQhg+V0HRKx5Pgt+5KR/WxghHLLYyWWnbDLPb4VCFWWILVmragAuMwjsiYURo/9vzIOoiFelMhXPZ8mRVc9Zzr3mx/7R6WfvMsuTpNKP0Au4+Gzvhn8kUkhExPfv1hOwh3l8odbm2pHMvmIwCusQMdo5QUkLr81gD0d09o+Q2K3ajcZfDyrGzSRxBtYoQza40dRVIrjqrUKI+ePko6QkvfoXb1eFuQqqwT5zx0PU1xFlKt61UCBnRFSpnFYcIRUQN99ShxRQFhDFwC34zc4ddp+XCBUSgQs/YVU8A42X1O5uAPXt+oqqoxW+SGlVWz8co0rNS6l7YgMxdr4JXGmidHkyEgC4v4P3sc8coVLOPH9N0+BM0o72OyuiQi37R1Qb95VdZZIYc+Dk0CF5P5FHYacr4RhStqzVFMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(508600001)(33656002)(82960400001)(6506007)(52536014)(83380400001)(122000001)(82950400001)(2906002)(7416002)(921005)(76116006)(5660300002)(8936002)(66946007)(66476007)(66556008)(38070700005)(8676002)(7696005)(10290500003)(71200400001)(64756008)(38100700002)(110136005)(9686003)(86362001)(54906003)(55016003)(186003)(316002)(66446008)(4326008)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pfYytGPMCWUDCQ3kSrjeUxpuafgPzaCpk9+fCpD9QMfEmOEOK8S7gw2jR9o5?=
 =?us-ascii?Q?JiJhRZ/s8bntu4pwFnDyolcyoOHmU/zorKZXDbFfd6/3+zVyxIi6Kj2eH5eV?=
 =?us-ascii?Q?Hzp4U94WnV8lL0eIf4IHCX/FR2wK8GQhRDJQmPhqH4T1gwoIQkEHnn4zMTj8?=
 =?us-ascii?Q?eemkBF94U96W9gqrmJfRvNb4hI4kmsX+FdV5UBMo0KLHTqm5ANR7asl6/oV0?=
 =?us-ascii?Q?MOFJqN55QVYWx4t8L+6mDhrS9X/wLFZ2+KfWf5IO51PONbqfOmztcF1MjDQy?=
 =?us-ascii?Q?adBdjownhzyZCdPt0AZdrlkdKXvSExxjerg0CimuileT0K9ui5jroYaJjUKt?=
 =?us-ascii?Q?ca1m5LmVlubAx+2JC7Y6MmSSBcWlfu7UoUWK+ckRLGCMgICwKyeFLhV4Im1y?=
 =?us-ascii?Q?gDwVeGrlwAS5E0/N5sFzJC1gNeBbpUoR4UA4fLcJ9PNi2YRBk9vDyWfrGdGh?=
 =?us-ascii?Q?hAFi1mUm2nVr7I5DuNd6qdGihaNU0A0nV0VBmYAQ3/k5Kw+Zy0nTnsb+idjR?=
 =?us-ascii?Q?96F1evRfU6TOkn3KXSIUTSrFnp5QnlVQj0xvxpsvpgVlLOb+C7oWc1ZarDY7?=
 =?us-ascii?Q?N6isjJ4tE3wO2ES3OTiGhi01WgJdVZRifJpCd7u9t94feQ8qyGmMqXUDkS1P?=
 =?us-ascii?Q?xlBGTmhODR2hozqFo/NpeXMpGk1HlWLFPy0DiS77Ot3hJEmq94bks5G7oZPC?=
 =?us-ascii?Q?XJoLKfgpfHCqT1HD30h844ePshd+IQ98fxGAsZst3hQXSU2/W/puwYFFkfqu?=
 =?us-ascii?Q?HuEf6G50lVmdczOgAWy3o56iHf49rLAnn0jec72bWSyVHHzq6HsuRBv+cpsE?=
 =?us-ascii?Q?FjM98JjhJk8CqXwYhvm/9MnKHoBb0c20lGjoScM4FrqgeNvjqXfELU6Z0JEM?=
 =?us-ascii?Q?p0H/NBWuwiCSwtLypxybuHVURRSeCvwHeFvSzgVFSdkwLc0CN+n8Ak2GU1vm?=
 =?us-ascii?Q?giUZtwfyFvprpv0DykI4L4KdZY7SlTV5KNP36PBAQCKsePKtAdGyhZhRHUkR?=
 =?us-ascii?Q?ILZwwmHvVazua8Bt5ox8G6WhkF8cnMh9LZhsdelW2l6P7SmtDu9gj+Qgy2Rs?=
 =?us-ascii?Q?VJOVn3xfrbGXU7gr5ozs9np1YguQfXHv3KkU2PnoNYr6p4km/cD2HhfOHwML?=
 =?us-ascii?Q?XAPKAo6kbY1HjLam64eF9pjgbX3quKMgBvXw7KDT3UxKHDhdmUudffaGNuTQ?=
 =?us-ascii?Q?eJGcIuBoALjevk1I8bkMxdqiEVtBxIbiPW2hlxsOkmAmWZaLT4KOwICcNRRZ?=
 =?us-ascii?Q?q2dMdCRAZNSID/djn8JL0ALxN3nbpj7rULS6EGAn8iRTtoO5bj0nKCe9K7m5?=
 =?us-ascii?Q?WcfUm1VlVMzq358okNCBRHnYnKb/PbIfxuqL2ADqMjOlydF39EzQ9P4Nj2Yc?=
 =?us-ascii?Q?itIqtjE91nt60Cjetjl8bHLoJzoI208qfTajCqmj68hmtZVi5cw1eCVXazTt?=
 =?us-ascii?Q?q18M1qwIRm5yY5UCSdJVdKwdUtzuxv+VdBkiLgvf0DCZjkGNmGwWcBaP9Exi?=
 =?us-ascii?Q?6U7RN8Kp016GNxCp59xEAu83qGVCb4ZRu5TUY0ZRAh12w9Zo4Hqtn1K5bM32?=
 =?us-ascii?Q?QrRgqjZJJswSXaXd5Q3KABVgEjHuhmB1g3X72vS0aRpUUBRi57sQf/FSPDF1?=
 =?us-ascii?Q?0pGshj7KMhSRSuR0rUMhNwxG4MQ961Zi691SadAgW9V2tMi9hXR8UxRegvfh?=
 =?us-ascii?Q?PK2xivmaluryXC8050qp6GzbIBy/02CTl6UGJCljuokPR+HS5VV3dX7s/8v3?=
 =?us-ascii?Q?itJDiQXM8cIliVlGn10PI+gJD/RXduj4vugMgjTXhJnjZA5bEhK4EhsLmzvn?=
x-ms-exchange-antispam-messagedata-1: zKBQkmfmPxn3cNjCG1DBGOAYVYd5OdJGjcU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5bb9f5-df25-4012-91bb-08da2870fe7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 17:11:39.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C03ZidqhIwXAI24xVeYs5QBDn2/wLGubeLBBxoRLVhrUQ8TSvaDw0SOnOzro8fDW/S/P4VEGdAosRo5TrbzzGXVeYavpr/c4M4nYp0HBSJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1372
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jeffrey Hugo <quic_jhugo@quicinc.com> Sent: Wednesday, April 27, 2022=
 7:08 AM
>=20
> In the multi-MSI case, hv_arch_irq_unmask() will only operate on the firs=
t
> MSI of the N allocated.  This is because only the first msi_desc is cache=
d
> and it is shared by all the MSIs of the multi-MSI block.  This means that
> hv_arch_irq_unmask() gets the correct address, but the wrong data (always
> 0).
>=20
> This can break MSIs.
>=20
> Lets assume MSI0 is vector 34 on CPU0, and MSI1 is vector 33 on CPU0.
>=20
> hv_arch_irq_unmask() is called on MSI0.  It uses a hypercall to configure
> the MSI address and data (0) to vector 34 of CPU0.  This is correct.  The=
n
> hv_arch_irq_unmask is called on MSI1.  It uses another hypercall to
> configure the MSI address and data (0) to vector 33 of CPU0.  This is
> wrong, and results in both MSI0 and MSI1 being routed to vector 33.  Linu=
x
> will observe extra instances of MSI1 and no instances of MSI0 despite the
> endpoint device behaving correctly.
>=20
> For the multi-MSI case, we need unique address and data info for each MSI=
,
> but the cached msi_desc does not provide that.  However, that information
> can be gotten from the int_desc cached in the chip_data by
> compose_msi_msg().  Fix the multi-MSI case to use that cached information
> instead.  Since hv_set_msi_entry_from_desc() is no longer applicable,
> remove it.
>=20
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 5800ecf..7aea0b7 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -611,13 +611,6 @@ static unsigned int hv_msi_get_int_vector(struct irq=
_data
> *data)
>  	return cfg->vector;
>  }
>=20
> -static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> -				       struct msi_desc *msi_desc)
> -{
> -	msi_entry->address.as_uint32 =3D msi_desc->msg.address_lo;
> -	msi_entry->data.as_uint32 =3D msi_desc->msg.data;
> -}
> -
>  static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
>  			  int nvec, msi_alloc_info_t *info)
>  {
> @@ -647,6 +640,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
>  	struct hv_retarget_device_interrupt *params;
> +	struct tran_int_desc *int_desc;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
>  	cpumask_var_t tmp;
> @@ -661,6 +655,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	pdev =3D msi_desc_to_pci_dev(msi_desc);
>  	pbus =3D pdev->bus;
>  	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> +	int_desc =3D data->chip_data;
>=20
>  	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
>=20
> @@ -668,7 +663,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id =3D HV_PARTITION_ID_SELF;
>  	params->int_entry.source =3D HV_INTERRUPT_SOURCE_MSI;
> -	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
> +	params->int_entry.msi_entry.address.as_uint32 =3D int_desc->address &
> 0xffffffff;
> +	params->int_entry.msi_entry.data.as_uint32 =3D int_desc->data;
>  	params->device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
> --
> 2.7.4

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

