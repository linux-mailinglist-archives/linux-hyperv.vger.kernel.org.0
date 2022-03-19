Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6064DE945
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Mar 2022 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiCSQVm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 19 Mar 2022 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCSQVj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 19 Mar 2022 12:21:39 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A84AE3E;
        Sat, 19 Mar 2022 09:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdGqp5gk2bJrzp5PHq7t3G4SgjpGErkcsLUS+9+6q88jD/wZ/UH2QJ65R0ap4yFX1VWcApMI+JRMNpcZeHeMjeUq4Jj91VXhkaEDzhrH7cPbktGmUo5DciVlNPaOjCirPoNFuNyacq4Xrz7tOYGBZjSDbDNwe7O6JqYJ90Jb6dv2B8PXmZ1GGjRuM0Iuz3zfIbLiymeTHypO99efgTRPgiC9NRJOcF9h4IZEpxNsy/emL5EKaUyfQk+lYb16VsehTeeQuL6rLqT/dOkUQvITORxNbh/HSn9DnozsBkCDtg7mXGsdNIew0MD8wv33XCtKTIiTTy95uoPEKi3vVTam6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s+bOdsgocQpAVt3qrMEE70Qb2dvEf0hDFq0PzQ7lL4=;
 b=D/A/+IWGNu4N38ZzAUxzV+rClXmnaVeobR5kNCxdTNrTQqpfjqTWOuHRF0g1hcEOU1/OoMKofJIIK+z6GdXMaEzDjm+9hFvSc0/Oehdly6hbDFe5S3G6YteiaPsN3CUSOJihBeJups+WAFy2sUFBClPKpZaprTAW086gk8ZIQooBT1QsIjjr6ZhMoEYK81RMq0i+jF7pOP1bfTshNwGr7xkqZ2DoOeiyj7XYI70EErfgLkAp3N+e6w82jB0Gq1J1vPi7ZoGWdJAx/FWmK09HXZqN4MmkWD4AAnNGb4qc36/gei8/Yr5zqEjnhY0GDK98ux7H7vmd0XhFjWFUJ3CE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s+bOdsgocQpAVt3qrMEE70Qb2dvEf0hDFq0PzQ7lL4=;
 b=bi33M9m+kCM8VH6k5bXYUjdHwJp6fG1k+jeBOhcQ1W+9dA60OCi0zBS4a0eRHb51mDacev2ddJH/yVYuAKZJtLdk0uJQyTPutLkyyeKEur91fC/IRgK3sCzvqf57zuXDwV1Oj1+PYgOx8Vu9ENpxBERwh2xSTXG14XBEGj6YAD8=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MN2PR21MB1424.namprd21.prod.outlook.com (2603:10b6:208:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.11; Sat, 19 Mar
 2022 16:20:14 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%4]) with mapi id 15.20.5123.001; Sat, 19 Mar 2022
 16:20:14 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] PCI: hv: Use IDR to generate transaction IDs for
 VMBus hardening
Thread-Topic: [PATCH 1/2] PCI: hv: Use IDR to generate transaction IDs for
 VMBus hardening
Thread-Index: AQHYOvB3U6bIyC7le0ugT4TzjlKbH6zG36Lg
Date:   Sat, 19 Mar 2022 16:20:13 +0000
Message-ID: <PH0PR21MB3025016203AAB9AB6ECB6A3ED7149@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
 <20220318174848.290621-2-parri.andrea@gmail.com>
In-Reply-To: <20220318174848.290621-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=51b7b6f4-a98b-4838-b084-f6e8e230d47d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-19T16:02:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39848ad5-8685-44be-b676-08da09c45926
x-ms-traffictypediagnostic: MN2PR21MB1424:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN2PR21MB14246A80FE56DC2C7850279FD7149@MN2PR21MB1424.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hTxm90iGGt2F89Qb2Eqvz19U84cWUAACrtOFBExFQD/2+kdTUu7doXo1k23YzhQjWLKEd8dDPmZnb7/0njuAau1B1VnZE/ZGrQCpW+s+qsoByLISUq4Y1//rpDbClh7xNTbsz1gXqasCAylWPD2MpLPuRzc4780Gr/YTl/7cACrtGSvm+RMZShCoh6pBTFKQ9uCyCJpcWkDqelCC/URkH0LvHgXgj0qDEUtL/qWoWnCHQ/P60KazNW6qe/5gCiF0/iSQHsI6vWW2ZKWWghV4t3mrhc+x3Mhzv4Tt172gO5MzMtfrtHZvoT1knPO/abmJm3Jmws2dpOVfaJ2CbbaBUEgptp1+lnPAgXIDqJ8CIMat6/TymA4YblePsxu920RRpBgMKy2HMaxJkfU48+X/A+ejD5H25PS6ddU7UcVci4UXp1jHIguq0GVOEmYB3tmWvoOETk+7JUc294UCv5upMwkekyMFhG6miWVV2PwPqOXmadX3GBisiPg1KnGn2azm++jw5DPBiDK2H8xEthJtntAQptRZR5y19+jGqSXepbgZCNROhg6qm34UTgIKWdT3AQpHWWGZCU60SpCvo6OQe/RR3/o49SG8cTm+Dpjn1RF45Lp5WH9Krmht2gPp43Y5Vvg8yPWnZUmNzuuTTTwyRt9BJNaAdTZnxfvHwEQ4oUoruooW67GmWLFgWZabPR87xfIX1Ae+uqDw63/yLktIt40Wlc9k1Aq88Aqe+x1qtCM3jVhClZAOacuQMzlPBsxWb3pFXqPXjQ3SOGYAPaYeFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(52536014)(8676002)(4326008)(2906002)(33656002)(86362001)(30864003)(5660300002)(8936002)(66556008)(55016003)(66946007)(54906003)(66476007)(66446008)(64756008)(110136005)(9686003)(76116006)(26005)(508600001)(38100700002)(186003)(71200400001)(122000001)(7696005)(6506007)(8990500004)(10290500003)(316002)(921005)(83380400001)(38070700005)(82960400001)(82950400001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GJHbdk2NpqGWDNTPEHDebkAa1tOtPq4CWyUSXEd9XTqAo+dxmhDBkFSmorm6?=
 =?us-ascii?Q?qgpvN8rG9VjMsGtcDVvD/hCmC/JMcIJOgrOEYF6NTZOFBu5QciseRiTDgqgM?=
 =?us-ascii?Q?gkDxJraBzUG3ESMk24hBLo308NqmwvmtcOCqYz8Zi8iaQjXpuCLmwqewctZF?=
 =?us-ascii?Q?KgoRzFh0ER2OxaeU/j3fthzIaw379g0OStdOloHYuhKCZlUOga4BojGNc+fi?=
 =?us-ascii?Q?J2aS079314eUzhWPr7FSN/ZsZoBYT6lx27btbCzlbd0uvsmCyIRubw70dBUF?=
 =?us-ascii?Q?f/j1GD3kIKxflkHyQL09Iw8g5Z8LE84yYshAR4PGpdIm+6uh2LR6sPSJ66il?=
 =?us-ascii?Q?9RfL+R12eEhiNjJNIZ8p3fD0ULeYORcjR9KQ0N8WLF1t1n/VslJ0FBBnIBZq?=
 =?us-ascii?Q?6IT7IrMCiz+8kpKVc+/Gnsr87eawfMcvOlpH02uW/TSsZq93Y0e9poXvssfl?=
 =?us-ascii?Q?ux/iplUUqMNrV+S7HrZ1rjqKHw/4PtbNohhekWGZa1khD4mDUlMVYIEqgDgd?=
 =?us-ascii?Q?MSpcaRtZRs4We+rcc4n8paDotgQe+BBwhW8OFlWytIBztQWz3aJGkIH38Jpf?=
 =?us-ascii?Q?+R1i3VIRNNgx+7EZ27s4CbWEvZWk+2IPNc1t208l4PgKO+LLgFeJkOa5gJEa?=
 =?us-ascii?Q?j6PZXVuVoa00fqyRWsjwZYTHczTKfnxT5FjEZ4678EboTfQ7K1pzSraDXp5y?=
 =?us-ascii?Q?bZ57jSl/Kppw/zDmRlMk6OhYFZZ65i9hHTgXVLXFBXzBKKubC6ikNiA6VbP6?=
 =?us-ascii?Q?JhzT7CM59loUwCfCs8ef29M1aX+NHqqA25supZMor4pZYZxtIdRVmvEC201Z?=
 =?us-ascii?Q?Z/cFdZF44Ixt73aDxrbO4KMBIQ51jyg1M6l/hYmXCcZH2D6hdEy76VCeZFsE?=
 =?us-ascii?Q?DXtK9WB//+po4UEBFfGRnRNioai6bv8prwV9LAB6PxAjNaiWJTzdXHFKZrGf?=
 =?us-ascii?Q?zOVzv54r6k5jjDeg4GOrX0X+lDcs0arzq5xChcjpg/AbLb0drxCvIcAA15em?=
 =?us-ascii?Q?ee+iniX5epflKaPOJPJXSOV0dwiB/pkJiFt3OXmkruESBd24CfXCEcn9AcZZ?=
 =?us-ascii?Q?MA9ejLZKPkSQ7Z/Vlpg2c39IEVf/WVVU3t7+pxG0b0NSXPIXeL1cS3XvZPRW?=
 =?us-ascii?Q?BRGZP4OWquWjrOLBrO/nmH4xwR45LYIOAMOV844arnz1FgIcEaj9YbpXyM9u?=
 =?us-ascii?Q?2hoA73fnvtykPb2cxm0yuB8qhU1F/pAL+SQApHtzu3jlwChUqWora/qKDV2q?=
 =?us-ascii?Q?aHHDq3XDZ7iHIruCwnPo4wUXU+60CQb9o+qiYwRva8GYS6vntNaebKx7QQ3V?=
 =?us-ascii?Q?rJU9Tl1VHtpgJwxTTVty5R7JD4+TybwB4ITq6ZBXV1h+sooXuL7EAJJVuiLD?=
 =?us-ascii?Q?h/oDwt7YxZYhchf5jqbh3E/ujaWhy4yxDl+x8N81m9Xq0K6ml8yAlWBptYpl?=
 =?us-ascii?Q?4aupMZuwRxPELB7aZWUrcyudMZBCICUVaa6apIg5t4WkrNJBIdB1Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39848ad5-8685-44be-b676-08da09c45926
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 16:20:13.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWcwCdbaYlXJgL+XFw0WwtpBYtq/KSqIjT7dtTZSHXAIRUZwS3cqOhnHBr9GkYhL9FSI3MpeorIdNlnqsfb3j0wXZ7Vmq26Xh4s7ui3OaLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1424
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, March=
 18, 2022 10:49 AM
>=20
> Currently, pointers to guest memory are passed to Hyper-V as transaction
> IDs in hv_pci.  In the face of errors or malicious behavior in Hyper-V,
> hv_pci should not expose or trust the transaction IDs returned by
> Hyper-V to be valid guest memory addresses.  Instead, use small integers
> generated by IDR as request (transaction) IDs.

I had expected that this code would use the next_request_id_callback
mechanism because of the race conditions that mechanism solves.  And
to protect against a malicious Hyper-V sending a bogus second message
with the same requestID, the requestID needs to be freed in the
onchannelcallback function as is done with vmbus_request_addr().
The VMbus message traffic in this driver is a lot lower volume than in
netvsc (for example), but theoretically it seems like the same problems cou=
ld
occur.  I think my earlier email sketching out a solution over-simplified t=
he
problem and was misleading.

Michael

>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 190 ++++++++++++++++++++--------
>  1 file changed, 135 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ae0bc2fee4ca8..fbc62aab08fdc 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -495,6 +495,9 @@ struct hv_pcibus_device {
>  	spinlock_t device_list_lock;	/* Protect lists below */
>  	void __iomem *cfg_addr;
>=20
> +	spinlock_t idr_lock; /* Serialize accesses to the IDR */
> +	struct idr idr; /* Map guest memory addresses */
> +
>  	struct list_head children;
>  	struct list_head dr_list;
>=20
> @@ -1208,6 +1211,27 @@ static void hv_pci_read_config_compl(void *context=
, struct
> pci_response *resp,
>  	complete(&comp->comp_pkt.host_event);
>  }
>=20
> +static inline int alloc_request_id(struct hv_pcibus_device *hbus,
> +				   void *ptr, gfp_t gfp)
> +{
> +	unsigned long flags;
> +	int req_id;
> +
> +	spin_lock_irqsave(&hbus->idr_lock, flags);
> +	req_id =3D idr_alloc(&hbus->idr, ptr, 1, 0, gfp);
> +	spin_unlock_irqrestore(&hbus->idr_lock, flags);
> +	return req_id;
> +}
> +
> +static inline void remove_request_id(struct hv_pcibus_device *hbus, int =
req_id)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hbus->idr_lock, flags);
> +	idr_remove(&hbus->idr, req_id);
> +	spin_unlock_irqrestore(&hbus->idr_lock, flags);
> +}
> +
>  /**
>   * hv_read_config_block() - Sends a read config block request to
>   * the back-end driver running in the Hyper-V parent partition.
> @@ -1232,7 +1256,7 @@ static int hv_read_config_block(struct pci_dev *pde=
v, void
> *buf,
>  	} pkt;
>  	struct hv_read_config_compl comp_pkt;
>  	struct pci_read_block *read_blk;
> -	int ret;
> +	int req_id, ret;
>=20
>  	if (len =3D=3D 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
> @@ -1250,16 +1274,19 @@ static int hv_read_config_block(struct pci_dev *p=
dev, void
> *buf,
>  	read_blk->block_id =3D block_id;
>  	read_blk->bytes_requested =3D len;
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.pkt, GFP_KERNEL);
> +	if (req_id < 0)
> +		return req_id;
> +
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, read_blk,
> -			       sizeof(*read_blk), (unsigned long)&pkt.pkt,
> -			       VM_PKT_DATA_INBAND,
> +			       sizeof(*read_blk), req_id, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	ret =3D wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	if (comp_pkt.comp_pkt.completion_status !=3D 0 ||
>  	    comp_pkt.bytes_returned =3D=3D 0) {
> @@ -1267,11 +1294,14 @@ static int hv_read_config_block(struct pci_dev *p=
dev, void
> *buf,
>  			"Read Config Block failed: 0x%x, bytes_returned=3D%d\n",
>  			comp_pkt.comp_pkt.completion_status,
>  			comp_pkt.bytes_returned);
> -		return -EIO;
> +		ret =3D -EIO;
> +		goto exit;
>  	}
>=20
>  	*bytes_returned =3D comp_pkt.bytes_returned;
> -	return 0;
> +exit:
> +	remove_request_id(hbus, req_id);
> +	return ret;
>  }
>=20
>  /**
> @@ -1313,8 +1343,8 @@ static int hv_write_config_block(struct pci_dev *pd=
ev, void
> *buf,
>  	} pkt;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_write_block *write_blk;
> +	int req_id, ret;
>  	u32 pkt_size;
> -	int ret;
>=20
>  	if (len =3D=3D 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
> @@ -1340,24 +1370,30 @@ static int hv_write_config_block(struct pci_dev *=
pdev,
> void *buf,
>  	 */
>  	pkt_size +=3D sizeof(pkt.reserved);
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.pkt, GFP_KERNEL);
> +	if (req_id < 0)
> +		return req_id;
> +
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, write_blk, pkt_size,
> -			       (unsigned long)&pkt.pkt, VM_PKT_DATA_INBAND,
> +			       req_id, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	ret =3D wait_for_response(hbus->hdev, &comp_pkt.host_event);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	if (comp_pkt.completion_status !=3D 0) {
>  		dev_err(&hbus->hdev->device,
>  			"Write Config Block failed: 0x%x\n",
>  			comp_pkt.completion_status);
> -		return -EIO;
> +		ret =3D -EIO;
>  	}
>=20
> -	return 0;
> +exit:
> +	remove_request_id(hbus, req_id);
> +	return ret;
>  }
>=20
>  /**
> @@ -1407,7 +1443,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpd=
ev,
>  	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	int_pkt->int_desc =3D *int_desc;
>  	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
> -			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
> +			 0, VM_PKT_DATA_INBAND, 0);
>  	kfree(int_desc);
>  }
>=20
> @@ -1688,9 +1724,8 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
> -
> +	int req_id, ret;
>  	u32 size;
> -	int ret;
>=20
>  	pdev =3D msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
>  	dest =3D irq_data_get_effective_affinity_mask(data);
> @@ -1750,15 +1785,18 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata,
> struct msi_msg *msg)
>  		goto free_int_desc;
>  	}
>=20
> +	req_id =3D alloc_request_id(hbus, &ctxt.pci_pkt, GFP_ATOMIC);
> +	if (req_id < 0)
> +		goto free_int_desc;
> +
>  	ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
> -			       size, (unsigned long)&ctxt.pci_pkt,
> -			       VM_PKT_DATA_INBAND,
> +			       size, req_id, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret) {
>  		dev_err(&hbus->hdev->device,
>  			"Sending request for interrupt failed: 0x%x",
>  			comp.comp_pkt.completion_status);
> -		goto free_int_desc;
> +		goto remove_id;
>  	}
>=20
>  	/*
> @@ -1811,7 +1849,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  		dev_err(&hbus->hdev->device,
>  			"Request for interrupt failed: 0x%x",
>  			comp.comp_pkt.completion_status);
> -		goto free_int_desc;
> +		goto remove_id;
>  	}
>=20
>  	/*
> @@ -1827,11 +1865,14 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata,
> struct msi_msg *msg)
>  	msg->address_lo =3D comp.int_desc.address & 0xffffffff;
>  	msg->data =3D comp.int_desc.data;
>=20
> +	remove_request_id(hbus, req_id);
>  	put_pcichild(hpdev);
>  	return;
>=20
>  enable_tasklet:
>  	tasklet_enable(&channel->callback_event);
> +remove_id:
> +	remove_request_id(hbus, req_id);
>  free_int_desc:
>  	kfree(int_desc);
>  drop_reference:
> @@ -2258,7 +2299,7 @@ static struct hv_pci_dev *new_pcichild_device(struc=
t
> hv_pcibus_device *hbus,
>  		u8 buffer[sizeof(struct pci_child_message)];
>  	} pkt;
>  	unsigned long flags;
> -	int ret;
> +	int req_id, ret;
>=20
>  	hpdev =3D kzalloc(sizeof(*hpdev), GFP_KERNEL);
>  	if (!hpdev)
> @@ -2275,16 +2316,19 @@ static struct hv_pci_dev *new_pcichild_device(str=
uct
> hv_pcibus_device *hbus,
>  	res_req->message_type.type =3D PCI_QUERY_RESOURCE_REQUIREMENTS;
>  	res_req->wslot.slot =3D desc->win_slot.slot;
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.init_packet, GFP_KERNEL);
> +	if (req_id < 0)
> +		goto error;
> +
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, res_req,
> -			       sizeof(struct pci_child_message),
> -			       (unsigned long)&pkt.init_packet,
> +			       sizeof(struct pci_child_message), req_id,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		goto error;
> +		goto remove_id;
>=20
>  	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
> -		goto error;
> +		goto remove_id;
>=20
>  	hpdev->desc =3D *desc;
>  	refcount_set(&hpdev->refs, 1);
> @@ -2293,8 +2337,11 @@ static struct hv_pci_dev *new_pcichild_device(stru=
ct
> hv_pcibus_device *hbus,
>=20
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> +	remove_request_id(hbus, req_id);
>  	return hpdev;
>=20
> +remove_id:
> +	remove_request_id(hbus, req_id);
>  error:
>  	kfree(hpdev);
>  	return NULL;
> @@ -2648,8 +2695,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
> -	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
> -			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
> +	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt, sizeof(*ejct_pkt), 0,
>  			 VM_PKT_DATA_INBAND, 0);
>=20
>  	/* For the get_pcichild() in hv_pci_eject_device() */
> @@ -2709,6 +2755,7 @@ static void hv_pci_onchannelcallback(void *context)
>  	struct pci_dev_inval_block *inval;
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
> +	unsigned long flags;
>=20
>  	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
>  	if (!buffer)
> @@ -2743,11 +2790,19 @@ static void hv_pci_onchannelcallback(void *contex=
t)
>  		switch (desc->type) {
>  		case VM_PKT_COMP:
>=20
> -			/*
> -			 * The host is trusted, and thus it's safe to interpret
> -			 * this transaction ID as a pointer.
> -			 */
> -			comp_packet =3D (struct pci_packet *)req_id;
> +			if (req_id > INT_MAX) {
> +				dev_err_ratelimited(&hbus->hdev->device,
> +						    "Request ID > INT_MAX\n");
> +				break;
> +			}
> +			spin_lock_irqsave(&hbus->idr_lock, flags);
> +			comp_packet =3D (struct pci_packet *)idr_find(&hbus->idr,
> req_id);
> +			spin_unlock_irqrestore(&hbus->idr_lock, flags);
> +			if (!comp_packet) {
> +				dev_warn_ratelimited(&hbus->hdev->device,
> +						     "Request ID not found\n");
> +				break;
> +			}
>  			response =3D (struct pci_response *)buffer;
>  			comp_packet->completion_func(comp_packet->compl_ctxt,
>  						     response,
> @@ -2858,8 +2913,7 @@ static int hv_pci_protocol_negotiation(struct hv_de=
vice
> *hdev,
>  	struct pci_version_request *version_req;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> -	int ret;
> -	int i;
> +	int req_id, ret, i;
>=20
>  	/*
>  	 * Initiate the handshake with the host and negotiate
> @@ -2877,12 +2931,18 @@ static int hv_pci_protocol_negotiation(struct hv_=
device
> *hdev,
>  	version_req =3D (struct pci_version_request *)&pkt->message;
>  	version_req->message_type.type =3D PCI_QUERY_PROTOCOL_VERSION;
>=20
> +	req_id =3D alloc_request_id(hbus, pkt, GFP_KERNEL);
> +	if (req_id < 0) {
> +		kfree(pkt);
> +		return req_id;
> +	}
> +
>  	for (i =3D 0; i < num_version; i++) {
>  		version_req->protocol_version =3D version[i];
>  		ret =3D vmbus_sendpacket(hdev->channel, version_req,
> -				sizeof(struct pci_version_request),
> -				(unsigned long)pkt, VM_PKT_DATA_INBAND,
> -
> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +				       sizeof(struct pci_version_request),
> +				       req_id, VM_PKT_DATA_INBAND,
> +
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  		if (!ret)
>  			ret =3D wait_for_response(hdev, &comp_pkt.host_event);
>=20
> @@ -2917,6 +2977,7 @@ static int hv_pci_protocol_negotiation(struct hv_de=
vice
> *hdev,
>  	ret =3D -EPROTO;
>=20
>  exit:
> +	remove_request_id(hbus, req_id);
>  	kfree(pkt);
>  	return ret;
>  }
> @@ -3079,7 +3140,7 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> -	int ret;
> +	int req_id, ret;
>=20
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
> @@ -3098,8 +3159,14 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	d0_entry->message_type.type =3D PCI_BUS_D0ENTRY;
>  	d0_entry->mmio_base =3D hbus->mem_config->start;
>=20
> +	req_id =3D alloc_request_id(hbus, pkt, GFP_KERNEL);
> +	if (req_id < 0) {
> +		kfree(pkt);
> +		return req_id;
> +	}
> +
>  	ret =3D vmbus_sendpacket(hdev->channel, d0_entry, sizeof(*d0_entry),
> -			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
> +			       req_id, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (!ret)
>  		ret =3D wait_for_response(hdev, &comp_pkt.host_event);
> @@ -3112,12 +3179,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev=
)
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
>  			comp_pkt.completion_status);
>  		ret =3D -EPROTO;
> -		goto exit;
>  	}
>=20
> -	ret =3D 0;
> -
>  exit:
> +	remove_request_id(hbus, req_id);
>  	kfree(pkt);
>  	return ret;
>  }
> @@ -3175,11 +3240,10 @@ static int hv_send_resources_allocated(struct hv_=
device
> *hdev)
>  	struct pci_resources_assigned *res_assigned;
>  	struct pci_resources_assigned2 *res_assigned2;
>  	struct hv_pci_compl comp_pkt;
> +	int wslot, req_id, ret =3D 0;
>  	struct hv_pci_dev *hpdev;
>  	struct pci_packet *pkt;
>  	size_t size_res;
> -	int wslot;
> -	int ret;
>=20
>  	size_res =3D (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
>  			? sizeof(*res_assigned) : sizeof(*res_assigned2);
> @@ -3188,7 +3252,11 @@ static int hv_send_resources_allocated(struct hv_d=
evice
> *hdev)
>  	if (!pkt)
>  		return -ENOMEM;
>=20
> -	ret =3D 0;
> +	req_id =3D alloc_request_id(hbus, pkt, GFP_KERNEL);
> +	if (req_id < 0) {
> +		kfree(pkt);
> +		return req_id;
> +	}
>=20
>  	for (wslot =3D 0; wslot < 256; wslot++) {
>  		hpdev =3D get_pcichild_wslot(hbus, wslot);
> @@ -3215,10 +3283,9 @@ static int hv_send_resources_allocated(struct hv_d=
evice
> *hdev)
>  		}
>  		put_pcichild(hpdev);
>=20
> -		ret =3D vmbus_sendpacket(hdev->channel, &pkt->message,
> -				size_res, (unsigned long)pkt,
> -				VM_PKT_DATA_INBAND,
> -
> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +		ret =3D vmbus_sendpacket(hdev->channel, &pkt->message, size_res,
> +				       req_id, VM_PKT_DATA_INBAND,
> +
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  		if (!ret)
>  			ret =3D wait_for_response(hdev, &comp_pkt.host_event);
>  		if (ret)
> @@ -3235,6 +3302,7 @@ static int hv_send_resources_allocated(struct hv_de=
vice
> *hdev)
>  		hbus->wslot_res_allocated =3D wslot;
>  	}
>=20
> +	remove_request_id(hbus, req_id);
>  	kfree(pkt);
>  	return ret;
>  }
> @@ -3412,6 +3480,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	spin_lock_init(&hbus->config_lock);
>  	spin_lock_init(&hbus->device_list_lock);
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> +	spin_lock_init(&hbus->idr_lock);
>  	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
>  					   hbus->bridge->domain_nr);
>  	if (!hbus->wq) {
> @@ -3419,6 +3488,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  		goto free_dom;
>  	}
>=20
> +	idr_init(&hbus->idr);
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> @@ -3537,6 +3607,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hv_free_config_window(hbus);
>  close:
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
>  free_dom:
> @@ -3556,7 +3627,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, =
bool
> keep_devs)
>  	struct hv_pci_compl comp_pkt;
>  	struct hv_pci_dev *hpdev, *tmp;
>  	unsigned long flags;
> -	int ret;
> +	int req_id, ret;
>=20
>  	/*
>  	 * After the host sends the RESCIND_CHANNEL message, it doesn't
> @@ -3599,18 +3670,23 @@ static int hv_pci_bus_exit(struct hv_device *hdev=
, bool
> keep_devs)
>  	pkt.teardown_packet.compl_ctxt =3D &comp_pkt;
>  	pkt.teardown_packet.message[0].type =3D PCI_BUS_D0EXIT;
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.teardown_packet, GFP_KERNEL);
> +	if (req_id < 0)
> +		return req_id;
> +
>  	ret =3D vmbus_sendpacket(hdev->channel, &pkt.teardown_packet.message,
> -			       sizeof(struct pci_message),
> -			       (unsigned long)&pkt.teardown_packet,
> +			       sizeof(struct pci_message), req_id,
>  			       VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) =3D=3D 0=
)
> -		return -ETIMEDOUT;
> +		ret =3D -ETIMEDOUT;
>=20
> -	return 0;
> +exit:
> +	remove_request_id(hbus, req_id);
> +	return ret;
>  }
>=20
>  /**
> @@ -3648,6 +3724,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	ret =3D hv_pci_bus_exit(hdev, false);
>=20
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>=20
>  	iounmap(hbus->cfg_addr);
>  	hv_free_config_window(hbus);
> @@ -3704,6 +3781,7 @@ static int hv_pci_suspend(struct hv_device *hdev)
>  		return ret;
>=20
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>=20
>  	return 0;
>  }
> @@ -3749,6 +3827,7 @@ static int hv_pci_resume(struct hv_device *hdev)
>=20
>  	hbus->state =3D hv_pcibus_init;
>=20
> +	idr_init(&hbus->idr);
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> @@ -3780,6 +3859,7 @@ static int hv_pci_resume(struct hv_device *hdev)
>  	return 0;
>  out:
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>  	return ret;
>  }
>=20
> --
> 2.25.1

