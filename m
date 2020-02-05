Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4856F152759
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2020 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBEIHp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Feb 2020 03:07:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgBEIHp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Feb 2020 03:07:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 01584cs5020301;
        Wed, 5 Feb 2020 08:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=E0ElS1yqNtwzr2cP28xtlM0g1ZRyoJurfDJUZv6uEOc=;
 b=AVMtcskimcJy4G147LJmvlnMTFsvpV5PiGFlWT+R5o8t7MDJG3Wc3nWPbqNku5qt+nI3
 71QzkvPiYs0vRY604MTfH+YBsD57dTIFKa5ujHguUCTlWUf2H4tGhg49gLi7gzSEVkio
 kL+hSb7+4XEwpu0XrmQPsFvw3LSW18lKcBpVv6nzyDXKxOy4AD0tnjI46ndltylcGYnD
 IH6/VMCisyWwWDEzHvj05SLf3tDbsVVw+IM4ldOR9xOO+dG25NW5IbIIIbiHKNeBzSVr
 WCf54uFPFUiTNuqnXbePjIXpmKdzFICtlYRvB0OyOPWyFVwJcsJKZep/6bTsgsMmYtln xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbp1c19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 08:07:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 01584XAj033702;
        Wed, 5 Feb 2020 08:07:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xykc4rsat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 08:07:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01587eAc027824;
        Wed, 5 Feb 2020 08:07:40 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 00:07:39 -0800
Date:   Wed, 5 Feb 2020 11:07:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Hu <weh@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [bug report] video: hyperv: hyperv_fb: Use physical memory for
 fb on HyperV Gen 1 VMs.
Message-ID: <20200205080733.GU11068@kadam>
References: <20200205054359.ynzdaq6lalb2sv7w@kili.mountain>
 <SG2P153MB0380F76124DEE4F3728C056DBB020@SG2P153MB0380.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2P153MB0380F76124DEE4F3728C056DBB020@SG2P153MB0380.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050066
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Wed, Feb 05, 2020 at 07:21:31AM +0000, Wei Hu wrote:
> Hello Dan,
> 
> > -----Original Message-----> 
> > Hello Wei Hu,
> > 
> > The patch 3a6fb6c4255c: "video: hyperv: hyperv_fb: Use physical memory for
> > fb on HyperV Gen 1 VMs." from Dec 9, 2019, leads to the following static
> > checker warning:
> > 
> > 	drivers/video/fbdev/hyperv_fb.c:991 hvfb_get_phymem()
> > 	error: 'vmem' came from dma_alloc_coherent() so we can't do
> > virt_to_phys()
> > 
> > drivers/video/fbdev/hyperv_fb.c
> >    960  static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
> >    961                                     unsigned int request_size)
> >    962  {
> >    963          struct page *page = NULL;
> >    964          dma_addr_t dma_handle;
> >    965          void *vmem;
> >    966          phys_addr_t paddr = 0;
> >    967          unsigned int order = get_order(request_size);
> >    968
> >    969          if (request_size == 0)
> >    970                  return -1;
> >    971
> >    972          if (order < MAX_ORDER) {
> >    973                  /* Call alloc_pages if the size is less than 2^MAX_ORDER */
> >    974                  page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> >    975                  if (!page)
> >    976                          return -1;
> >    977
> >    978                  paddr = (page_to_pfn(page) << PAGE_SHIFT);
> >    979          } else {
> >    980                  /* Allocate from CMA */
> >    981                  hdev->device.coherent_dma_mask = DMA_BIT_MASK(64);
> >    982
> >    983                  vmem = dma_alloc_coherent(&hdev->device,
> >    984                                            round_up(request_size, PAGE_SIZE),
> >    985                                            &dma_handle,
> >    986                                            GFP_KERNEL | __GFP_NOWARN);
> >    987
> >    988                  if (!vmem)
> >    989                          return -1;
> >    990
> >    991                  paddr = virt_to_phys(vmem);
> > 
> > Pretty straight forward that the static checker is right but I can't give you any
> > hints how to fix it.
> > 
> 
> Thanks for reporting this. Would you let me know how I can reproduce this warning or
> Error message? The build on my side runs fine without such message.

Hm...  Sorry, I never publish this Smatch check.  I should do that.
Anyway HCH explains the rules a bit in this email:

https://lkml.org/lkml/2019/6/17/155

regards,
dan carpenter

