Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B04EE009
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Mar 2022 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiCaSCo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 31 Mar 2022 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiCaSCn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 31 Mar 2022 14:02:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2129.outbound.protection.outlook.com [40.107.243.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F8E182AE8;
        Thu, 31 Mar 2022 11:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiISI0G++af+KxZfT0imeO4QLCW7zstESh4KZGdYuD4RAar+qXQixcfApR8at38zan7jMhxeDgQZC+e9hswq2Kly2z8g4P0xVV7Yf6oOK2dLzpi7YgySRHnxJN65ZKLx/oLf3wElKvg7Nl5ADB+Zvg4RsY7OzRow5gJdGb9igexy5hIbWbxc29potztHGr1+631GGreGTW4iZPciQS2mn0Pa+jM+lmSBbbkEhUtmn4BjAxay/qYyHZ3y06BBhaMASzRNBa3ZA0FrM8r/meTpit7ZoqXwmglCfI5mFSqPCnYmGmnnia85TXrXFD8QcRl6/P5i0UO0rRywAHS0UwlVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHHUBbImTULdo7FyFAjOG8A0mAzzgIMkl2qcGflkxhM=;
 b=d/51E7AuzDdIAUglTz8cWLhnoEOphsb4DFv+URH8QdNeQ5MzgtpIhAHdQwfoJawnVbZiIJyAwrjPshEEd37eY70UZE4jF3UneCNTwpLFzA9th9CO/Y4RQTeOJg1UtEi14mWhOl/amNUSXAJ9md/KR3U3ot2JK79c4N2jWGIhUUZQ3CqGoTxnRjNbULbGxwpTFIyTbEEbOo+9x9IFKjS9BfHbaIyPsBYNUxH3GNVQ9savdtTUeTBUvEvjha1W/RwAiCjL4U5pdKC1oXVyfuwXnFRiaVAoJ3Y4SQ2V6lacCJZtIDmgwT2ggC7XeHGeiN3nJdcAEFHD2PVXvRcytC1VNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHHUBbImTULdo7FyFAjOG8A0mAzzgIMkl2qcGflkxhM=;
 b=iytvryoH7XNe0PmR9mik46UMcBpTb2hT7JNrIPaiZmKtCjl0ZzAtlE6g6mDOMVd8/6yH9OrXusCr/jULdKIKyIFX0diYka75wkv5JrpxfawOwg12TNYTMgR+1Aac3PYgf5xByrJNUycnHE0uWW2Wo8BAWPoH7JWUiG+tpNVVlfc=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1259.namprd21.prod.outlook.com (2603:10b6:5:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 18:00:53 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22%5]) with mapi id 15.20.5144.011; Thu, 31 Mar 2022
 18:00:53 +0000
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
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/4] Drivers: hv: vmbus: Remove special code for
 unsolicited messages
Thread-Topic: [RFC PATCH 1/4] Drivers: hv: vmbus: Remove special code for
 unsolicited messages
Thread-Index: AQHYQrIn2sYSQ2mrxke3i7GPpdFhdKzZzOSg
Date:   Thu, 31 Mar 2022 18:00:53 +0000
Message-ID: <PH0PR21MB3025C5AFA74745E2F87F6178D7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-2-parri.andrea@gmail.com>
In-Reply-To: <20220328144244.100228-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8d6541b8-7c2a-44bf-b290-ffe935e4d443;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-31T18:00:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1116a117-52d9-47e7-9a9c-08da1340660a
x-ms-traffictypediagnostic: DM6PR21MB1259:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB1259BA8473405554E3719B8AD7E19@DM6PR21MB1259.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9pKjEj4NIKmyk0wZhH1IWaNbqHMI+nB7Rakrgm0F0JhIaXbBFSjTiT7kLVBBw4Mgs/qvDpyv3xCaZGKyTb1kUXu8/zvNNCfvTMbUFOStS4xlNIOS+RWXknQB7/L+vjZi7DTvzruLG3RuGez7n3uYf2t7Jmol0+FyPUtxIZNHTIVIktCfP4ub5P1HApGYReJ4CeC0aZ74DvtbIlHIChxcuUuyZE0e0/7jzz1AI205Lmjy10GYeKZNocLpInTZAYbMZ3nMo/sNdYI+gAX6vKYd8Z8Qseb6rIqp6/Z9o5ImwmsRQAc4sSGljzMum86Fw+uugVtJQZNpmm4tUie3dR7pUKqoXEp2YKsUW+3cYJVSyUP2p8o9Abz2E5f6O3pePbJSwxP/dFc/RVmojuqmyBrkZ5aicbv03+/rHmDBoeywO79mSKBT1H3dfIrRO2m7daO+DXbVMXfLyMvAJRy2srgVd6y+Zzu/rYngBbX+rB2WKHysMvnQD4xS5Stk8SQ3jHsp1fqRpVuw2vqkXK/KxV5Fl2oWYOcnkxoB+gXOP7eXwTHoT9Xbbhodr2gwHGhkgJxEhPscKXmMrsLVKNjUDvQBkAFQCgvgtixSwk4mM/1+a7H9ReVw0Y2+jRQNdqgODaVkwn6DXKpMk6SfQdi3K7cgnhNaG+ik7qloBc4GTs/ScKFcZS1MIpmWyuAe7Pw5rRe/CJk3vrzq1CC8XWSOrzXP3aYO0sJlAuI8+hcbXesiuKXCPuOzFc0kj2Nhjz0G/PQkNRUHkko4vRJC4TipVbGXDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8936002)(38100700002)(71200400001)(66446008)(66476007)(5660300002)(64756008)(55016003)(52536014)(921005)(76116006)(15650500001)(8676002)(186003)(82950400001)(82960400001)(4326008)(26005)(83380400001)(2906002)(86362001)(122000001)(66556008)(38070700005)(6506007)(9686003)(316002)(10290500003)(66946007)(33656002)(508600001)(8990500004)(7696005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njlCo9a8QbBGcgSLTjJoDtjuAXZyjdUtTqHwXA51insb0gO3/YixHJSrLb8l?=
 =?us-ascii?Q?iM4xC/dn70zje4/8E/sK8dfg+YOrTDN1dHWduErxG4yeg5LJHy9aHazzglJy?=
 =?us-ascii?Q?7Z+ard8sdQMTfT6RCUu/fmZ6xyOnM2WhyAqXkLXMH2xqcAN4JvJEZcuAkdB1?=
 =?us-ascii?Q?w+KAVl4LXAsoKJzXQo9vHeCJhtethOdBrtV0qJ/BsRi2whRKf3qnshxWG/La?=
 =?us-ascii?Q?2NMyVbN5VvqUZe6mP+RhfhVvNAseizERqQ2oRRl8hDCSKpcA4ikxs9C/fOxY?=
 =?us-ascii?Q?I6PdWQGFA9GOTHqS9zr5i8UQ62N4AsKRt4weIAijajhfEUjD2pxJsC/hjx6c?=
 =?us-ascii?Q?xLqCRHW4xnFYyTUkk6G5SxohspACtpG2OBKmHOXcZZN7wlX1u1ZX8rT/DpHY?=
 =?us-ascii?Q?4aIXS6OfOv7DPZcfNJOEP6NZFkgApei7DI4eENFm5Dir0JcEWiMs6LR5GYZ2?=
 =?us-ascii?Q?sV0lIRufOxv28A2WHPUL9iAIejtb/uPKk+U4dhpmCBKkXeZ6kG5XgdqdQ5gW?=
 =?us-ascii?Q?zZrgotJKcpUPgSd2/LQ0HW+t+r4+NQSwpDHzViKmfkjLXeI/xJabVsNrHZDv?=
 =?us-ascii?Q?UY6Ryac++CmPGYLgSRAx4nKfXIpZHJvYcoVXVwx13OVxacMHHlxx/yZeHIA3?=
 =?us-ascii?Q?eP8DCMkzwgruX5zE4Feh633KKBN2fLbN2r1lZHKze9Btg7CWSy82mPyISDC8?=
 =?us-ascii?Q?FTwiiBSiCusBuez9Pwp4p4Q5EbqARZrTdasC0tUUAuH0QkEXYiZl1sCZg04o?=
 =?us-ascii?Q?Qwf9H8WZ0tgqK4onXplaSXQ0hvH39t+9CHngC3y25g44taGoG0TehCPZTJoz?=
 =?us-ascii?Q?Q5NEwksGkkI4nsQjmROcTADMAuhx3k8vqhxmBJJ0w6Z7o6x+JOsrlrDRGnhl?=
 =?us-ascii?Q?O1KD7IKhn1m8e4ShLB8J7UfVwwzNQ9pEQsYZA/1SCHjwr7gys69LSM277aay?=
 =?us-ascii?Q?PRz4zUNVWwIBhRDcZW7z01MAAuBlGNOlCxOAadEg/7Bl8pU0NolhCKESjYeQ?=
 =?us-ascii?Q?OOrYlK2IjAmPJaErhwspvHEMmCLXeJvTP18GesoVEuflF85kyNz0Vwli5FFt?=
 =?us-ascii?Q?10l3yblrVv4oAtqrjTK0q9rv70v38TkAqe7cBqUaRcXF8o5m748tGyKfrpUK?=
 =?us-ascii?Q?iiEDAm4Mjh2BhmPUjcjwsDdm6WgLkzZHgW2631jpShZ9EihDWU7CGSoM7RUy?=
 =?us-ascii?Q?7PRBsJ60tF2CU1g4H2UZd4Hp6mKI/gRT4ttp2+KYNRusNs+kGNDKRLIi+lcR?=
 =?us-ascii?Q?cZAtiaHV0Aln26i+T3o0G7OqaUqJf2ip3srsJAQp4QIJ3+s8tYzcPvYjzC1i?=
 =?us-ascii?Q?sg+d/OjVHjyydxuqo6G9zXZo4SOVZFDLwCB/N+n+5I/vHW7I8eKi3RViOTuj?=
 =?us-ascii?Q?2saYmRTQ3MkMhLf+867LIsJ74DuWuEsuSD3Ae2C9hQmN5zet95Jl9JNANutc?=
 =?us-ascii?Q?1OWNmmChOXSBDuEKvgrzj4AbEfxex71/0SLASxeLdI6hAX0k/qzSR4dgOF+s?=
 =?us-ascii?Q?wFnMIZ5UmL15iWqyOpokUL7GwFNwYJFS1U/DP6hTRSnA+UgR7Ulsul9pcmHL?=
 =?us-ascii?Q?salfSu6gjMnJuwOclMs72MiGWbKMhnMvO9NcZ8+yCVniUKVche+1R+LEIBCo?=
 =?us-ascii?Q?IXST537GQxuBH4tKMvyI8cHB/2gCd0BXaMVwpPeUP6dFX0ZNISol3I806XVX?=
 =?us-ascii?Q?BctY+t8J16RzWnjM/F0+C7nPPI0AxjGr6PF/Qn5ovVtVBgGNNIKIUhVlaJGy?=
 =?us-ascii?Q?rJc+IeYThBYKmN7y0MJknEpQcFtTBSA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1116a117-52d9-47e7-9a9c-08da1340660a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 18:00:53.4702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgvJ/w4ECuY5gaUKKwuROQPdLDZy6guH86PP21fhXabtqQLvJgiyMXNcDEUCugaxGEEt5i4hizZNWWPKfhnkd3vfBJ2upxcJ0gcKFqPeBLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, March=
 28, 2022 7:43 AM
>=20
> vmbus_requestor has included code for handling unsolicited messages
> since its introduction with commit e8b7db38449ac ("Drivers: hv: vmbus:
> Add vmbus_requestor data structure for VMBus hardening"); such code was
> motivated by the early use of vmbus_requestor from storvsc.  Since
> storvsc moved to a tag-based mechanism to generate/retrieve request IDs
> with commit bf5fd8cae3c8f ("scsi: storvsc: Use blk_mq_unique_tag() to
> generate requestIDs"), the special handling of unsolicited messages in
> vmbus_requestor is not useful and can be removed.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index dc5c35210c16a..a253eee3aeb1a 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1243,11 +1243,7 @@ u64 vmbus_next_request_id(struct vmbus_channel
> *channel, u64 rqst_addr)
>=20
>  	spin_unlock_irqrestore(&rqstor->req_lock, flags);
>=20
> -	/*
> -	 * Cannot return an ID of 0, which is reserved for an unsolicited
> -	 * message from Hyper-V.
> -	 */
> -	return current_id + 1;
> +	return current_id;
>  }
>  EXPORT_SYMBOL_GPL(vmbus_next_request_id);
>=20
> @@ -1268,15 +1264,8 @@ u64 vmbus_request_addr(struct vmbus_channel *chann=
el,
> u64 trans_id)
>  	if (!channel->rqstor_size)
>  		return VMBUS_NO_RQSTOR;
>=20
> -	/* Hyper-V can send an unsolicited message with ID of 0 */
> -	if (!trans_id)
> -		return trans_id;
> -
>  	spin_lock_irqsave(&rqstor->req_lock, flags);
>=20
> -	/* Data corresponding to trans_id is stored at trans_id - 1 */
> -	trans_id--;
> -
>  	/* Invalid trans_id */
>  	if (trans_id >=3D rqstor->size || !test_bit(trans_id, rqstor->req_bitma=
p)) {
>  		spin_unlock_irqrestore(&rqstor->req_lock, flags);
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

