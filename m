Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E156B189
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 06:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiGHE1G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jul 2022 00:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiGHE1E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 00:27:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9F1E3F1;
        Thu,  7 Jul 2022 21:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA21+/MM8P8lElI843Sjc+lXRmDwDRKwRqr0f0IYQY58RxyulxDLQRBHT3r2zp4JnoqfiEFXFgOxCH91aiWYlKLTbX5bGUSaEVWLvROmkG4hpMxlTcFXWZfDQBHhZ7BZ/Ru1XLqm5O0wX/bU8E7CnsOSrnA/yL0T8P3fVEnjblagtfWNQAUz4Bh7Yoa8Of20WZYRszDCBdCCuFkYUku2oVcKi/1B1ylYWaunpPRJ2ct6Wn5/qdEOAbVrCq0+Gnnp8u278TiUlDWZ9WZOh5yqT8Ge+DhOlyjdwc6pvISb8VvsTaMLfp/FJh/NHRPjagL8AjbcKifBz9iwGptJFxEGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7cHyUiFjWPR20N7hpY7EQ4lanzXZA1ffL3bfasYMTE=;
 b=FwT6SBty6WSZn4z0EMOgfWbuOYe9JfY8C66kNU6xUegreBkvEYdV+hNXPuqZ7uqy6fDZdBSJrcPHxcQV0c11s+Yoe3+R0bbNn3FKPKKFFjM+Q0FeDYVCgdCONwfiXsbh6GNvIzs3QUbT0rfTe7IRCJa6RSi2CnY56O5xQajkC1bo89lKUtZETWBYbvj3MZ7B4IOc17mX/TGdTcTNJ8lDBkYpTxz/iRwPnJ3UIkI70iEOoV8RnNRhh6NlD2NHqlZQESrEY5bWUB8G7Sm02GViUKw4DGPMt+TnvnJmhnssTStyeQeaZSeA+WWmORA7w4iZixbS0UzYsPatlXpOtFvWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7cHyUiFjWPR20N7hpY7EQ4lanzXZA1ffL3bfasYMTE=;
 b=Wuf53HLLfVxpfxVO5WxUg+WnIFqwEWDI8vx+42YoIm/IBFJBuOaLm4J0J817QZwL4W8AAMGVyJ3o2j1qgw1avjYUUCL9r5CoAl78pxPvU4L03o8Cy2q1uXfLY0PJmDNZxDAJepa5yMcH/ZK8MZ79IO5O75YFk7XmdxDGtQqTOKA=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3119.namprd21.prod.outlook.com (2603:10b6:510:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.4; Fri, 8 Jul
 2022 04:27:01 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Fri, 8 Jul 2022
 04:27:00 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Samuel Holland <samuel@sholland.org>, Marc Zyngier <maz@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Take a const cpumask in
 hv_compose_msi_req_get_cpu()
Thread-Topic: [PATCH] PCI: hv: Take a const cpumask in
 hv_compose_msi_req_get_cpu()
Thread-Index: AQHYkmSZQIzjcqGExkGJmNZbXXkOgK1z4LWA
Date:   Fri, 8 Jul 2022 04:27:00 +0000
Message-ID: <PH0PR21MB3025E51C68B0F77F54299768D7829@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220708004931.1672-1-samuel@sholland.org>
In-Reply-To: <20220708004931.1672-1-samuel@sholland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fb2da16-44c6-45c5-b9a6-ce0854679937;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-08T04:25:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 172f12c6-d798-41e2-0e8d-08da609a1a28
x-ms-traffictypediagnostic: PH7PR21MB3119:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWGlWVJppJgQoRc0ELXAWeTEpKp1v6gJqYEAF/W4bKeOplWzPuJHB/Rn067pbx06u2S9v90tSOGkAk8/Fg1xu8TlszTKInu02IT4vYdX6XloRu6yxWa4Sff/EdNwfeVs8sVwg6L8b34xFj57eXTNQ8GS9z5+NmsbiMO8Sb2BjsKhvFEvIdkmCe75bTx+tp8zIvV9SE6yXyVwGedIGyAZ+YBEE+cjqDJzMw8H/tyJlW9O4sS0wh5sXYPtXHB/FAZm2jdZu+UfC/G6K2s2wYKXQsigyTdbD71Q5ZPwFk6eEKHsS+g0A1pMTcWOsA1dlp2cfTLFpMgWWDJqiJ69Uqed1vj32A0DpMI8T4y2NkPQsEPDjFdKQ2/dF9MxPsNtdxZGFWA6luj5fUrapMNfgUZ22yLlykM8+6xW5oV3Q2OmGsFPGVDqNQ0TUAcsqf6VAgRFS/Dnrm9hvL6GkhaDSLQj4t9r+kL3qGKRQzg83x5W9OfocD3r7YyX2WowxY5IzVLY57BvE6H5yRMTUwpAt/gv6opWWJL+j8SqmZIcUq3eGi2kLC9Pkr3omzk2ELmdfDUsSZC6hfOljq38x7sd4N6fQZoJgQ329lrrct7pnw64qMXieDRb9atrvLgKdJkrROys8jCAnoeU6Id/gtJHuai2QCcV7IJ2Aa00VNYywSCn4/9nmbEc03xFMFYbquD4O6q9VOEetOus+ZZrPNQ1vzpWGrBPeITuWDr8uZ0JtjTR5q97lhLrN0MxbZtkJzHevynRHrfHGE1j7hMk3ZsTx1ov5/bG5k1LbLORje9Qu6Ak4zZ42mLAMYzBRPA9UMz11+2iaLSBi9eTaS6j6qY1JSYmFQ6H7NJ8zu0PjRj4wPcbPwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199009)(186003)(54906003)(110136005)(38070700005)(55016003)(7416002)(71200400001)(83380400001)(8990500004)(5660300002)(10290500003)(9686003)(38100700002)(26005)(2906002)(76116006)(52536014)(33656002)(82960400001)(8936002)(41300700001)(66476007)(122000001)(6506007)(8676002)(478600001)(7696005)(66556008)(64756008)(66446008)(66946007)(86362001)(4326008)(316002)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Ifnmt/ItQ9Uo/eZzczg6HQy8bCar9eo56c+B5fQYFXz0uDAw6fZudOG6nc?=
 =?iso-8859-2?Q?kYZH0uXILctuFiH3YlnrPxc4IKrdSATX8eqUi/e1a6rmzVKJVkSv7OwmEy?=
 =?iso-8859-2?Q?3ixLRJFdUqFLXXOc4NHMysxGKUGuC0q6PCZC6VVGwrEnLeHhUe2xymoci0?=
 =?iso-8859-2?Q?J/fbMMenXL9X5gDqXuvoNaLLOxrry9eiZLw5rSaqmSD4KkAAVIJcu16RjV?=
 =?iso-8859-2?Q?Sr71ESgfvH6KjR4TCCGMzj0sepSwX9FR9txYw8hqvQQvWfzZG+2rmq12rq?=
 =?iso-8859-2?Q?vKbh5wjYhXq7lo25wvHc2yskEaldgXakZ1v3U1+mr+tm/04ODB6BAy0Igo?=
 =?iso-8859-2?Q?2QGj0ZLzXoXDd8B8ZNl1+Mn3J1Ku47exxTpEbCngzOkdUqBK6WIUP+R2cY?=
 =?iso-8859-2?Q?OiZmWx3jDK1k6CW1TNFDHXVVxKc3KRXutg5rg8i8N6etkxOnfp9y7pqWWJ?=
 =?iso-8859-2?Q?AMVys1jE+EG6IqZCZbyIAAC/Dafzs0uA/Pu8cKhIy8LOzXyqQlJtY6JTP7?=
 =?iso-8859-2?Q?4IKWje4JretDF5sRSxgWcCflKkHh+iruOIClyEY3XJXBOAiWaJTgFBz1lt?=
 =?iso-8859-2?Q?OJwQQo0uahDKom3uFSUqOOFz7j0I/ldz/KuxZfqmjEc37QIN07WjK+P3AL?=
 =?iso-8859-2?Q?zWxbsI+IuZwov+COh+2oTq/j7T/pPkE+TYWse0c8jV7ZD7CrumCS/OMGuE?=
 =?iso-8859-2?Q?he71raWoX7j5rmHovIOtcOmJlO/bn8U+DSQRpPrk9IcdlTeE1OdqAfYdZT?=
 =?iso-8859-2?Q?lEEInjykuiFTyMoF2SXxVLmYWtkRKp+oPAz9kdOajPsWIDc5cq9PJSzx1p?=
 =?iso-8859-2?Q?4ak88jKPKXNQuR51reZlh5exyc0ImKbnD35zSUuB5ba6mr94c63A/pUJDr?=
 =?iso-8859-2?Q?BSa3k7MLnctO6tlLOJpkJTy/olhhCocHxD3xMlxziChZvK1PjOZxhxvA/N?=
 =?iso-8859-2?Q?WSww9XRxR2ASJlkYFEFImr0dWywXHveZTYzX6lSWTqAoN+8KH8wS2a/8Pu?=
 =?iso-8859-2?Q?tUB30unZfbLmAI+0CklqiPxR6CPBiOcJ6evei6qwbZexSdQsyESal48q8m?=
 =?iso-8859-2?Q?X7js+m7Me1py+ob6bJDMJA33EyHOsc7BfnyfwtAX5itnb4fGBRb4ryg8JD?=
 =?iso-8859-2?Q?bypMM/tU0Lu3MXmz37WwFf8/iiWEo2iOTk+SHrEfo22VBSH4aWz+j5en6h?=
 =?iso-8859-2?Q?0f9MgoYWhIl8j2w1YpsYmCk7HK/ubz8ZVS1vdlTRjsL7qcv0Mi+Wet/iIe?=
 =?iso-8859-2?Q?NfNVprKIeYe51VO7Qi5U74m+8Z86yXVycGyVfQWzjWE2qPRSXd2p/g7tUJ?=
 =?iso-8859-2?Q?aXGw+f92bXvF9NsPpPQy9huK7WCkV6057V2yuSrcKP2BqNkwHuWsn3mJ8m?=
 =?iso-8859-2?Q?DDPJYF2u9WhMRFQs4IsAHkwGYxRVAiWXGnlEJwGdmXd8wQFUljEeO4zzdu?=
 =?iso-8859-2?Q?0ikYt6jEzzBMImZwyTiPOcsGnLnMwZ0RHLzRT0aWS+IVC7Ka72ryoReyop?=
 =?iso-8859-2?Q?WZ/Sg/IAt103XnfRp3fiRq68v5Wy/nBzDpB+pQVxJyXd96wmp3q16UD3jE?=
 =?iso-8859-2?Q?y3+OHc9R0z1lCebqwy7E2HUiWcefzCwPhHM2gQ5MmG+bwcyDIXcI/3suVD?=
 =?iso-8859-2?Q?DLujl3MG5o9x1wbzniS07yyHHD/ZoWKeWqWj+wFOLqUytIXghQDv6JDA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172f12c6-d798-41e2-0e8d-08da609a1a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 04:27:00.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MmdBHxsOxvr25CS6tSdgF8WdxLbi4apCB3x2cbqm3Gan0KdDrkVL2IxuIF5miyyHS3diaUiemaTsDaAg+U0lRO7zGDgntvhlh3j1+0sSQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3119
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Samuel Holland <samuel@sholland.org> Sent: Thursday, July 7, 2022 5:5=
0 PM
>=20
> The cpumask that is passed to this function ultimately comes from
> irq_data_get_effective_affinity_mask(), which was recently changed to
> return a const cpumask pointer. The first level of functions handling
> the affinity mask were updated, but not this helper function.
>=20
> Fixes: 4d0b8298818b ("genirq: Return a const cpumask from irq_data_get_af=
finity_mask")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index aebada45569b..e7c6f6629e7c 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1635,7 +1635,7 @@ static u32 hv_compose_msi_req_v1(
>   * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
>   * by subsequent retarget in hv_irq_unmask().
>   */
> -static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
> +static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
>  {
>  	return cpumask_first_and(affinity, cpu_online_mask);
>  }
> --
> 2.35.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

