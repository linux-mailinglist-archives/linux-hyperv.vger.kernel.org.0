Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BB8152618
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2020 06:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgBEFoY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Feb 2020 00:44:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgBEFoX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Feb 2020 00:44:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0155iK2Q120429;
        Wed, 5 Feb 2020 05:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=rJtewkUfU2LcG3bD8az9ZFBoFWdU5e/5YszwKs8uxWk=;
 b=D89CVcNV491I5ZI6oXYVVMmqANuHf+HleV4jTV+sjOKwPs9X6jbc2CsnWlsrDJFdPEve
 F0eJsbLbsrhZt2hxNauAagUYrs0iOI7kaSAEFnXvzlOleWxKuzEuikKyfGd7rL435MaH
 EpqZ1jddC3AGpmCJccs6YCZttgnLsBKl4HfZLdgYtrAaD0rVhl4wW7srgy2p1O9TLm6u
 plDSQ0ZxxxNZGBaXU91DiBaCos9I9hztKP3B3eAGeANQQJ4G7ZAVY411Y6ILn4kTIl8l
 oi63eSedM15ZrLEQmhwLSs5ZtBGoRnPjd5p+H9Joi3LWVO+m/xq8ybOd57PKY8inPASM LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xykbp8t2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 05:44:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0155iG4M023640;
        Wed, 5 Feb 2020 05:44:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xykbqyf3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 05:44:16 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0155iBlf022691;
        Wed, 5 Feb 2020 05:44:11 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 21:44:10 -0800
Date:   Wed, 5 Feb 2020 08:43:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     weh@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Subject: [bug report] video: hyperv: hyperv_fb: Use physical memory for fb on
 HyperV Gen 1 VMs.
Message-ID: <20200205054359.ynzdaq6lalb2sv7w@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=593
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=642 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050047
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Wei Hu,

The patch 3a6fb6c4255c: "video: hyperv: hyperv_fb: Use physical
memory for fb on HyperV Gen 1 VMs." from Dec 9, 2019, leads to the
following static checker warning:

	drivers/video/fbdev/hyperv_fb.c:991 hvfb_get_phymem()
	error: 'vmem' came from dma_alloc_coherent() so we can't do virt_to_phys()

drivers/video/fbdev/hyperv_fb.c
   960  static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
   961                                     unsigned int request_size)
   962  {
   963          struct page *page = NULL;
   964          dma_addr_t dma_handle;
   965          void *vmem;
   966          phys_addr_t paddr = 0;
   967          unsigned int order = get_order(request_size);
   968  
   969          if (request_size == 0)
   970                  return -1;
   971  
   972          if (order < MAX_ORDER) {
   973                  /* Call alloc_pages if the size is less than 2^MAX_ORDER */
   974                  page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
   975                  if (!page)
   976                          return -1;
   977  
   978                  paddr = (page_to_pfn(page) << PAGE_SHIFT);
   979          } else {
   980                  /* Allocate from CMA */
   981                  hdev->device.coherent_dma_mask = DMA_BIT_MASK(64);
   982  
   983                  vmem = dma_alloc_coherent(&hdev->device,
   984                                            round_up(request_size, PAGE_SIZE),
   985                                            &dma_handle,
   986                                            GFP_KERNEL | __GFP_NOWARN);
   987  
   988                  if (!vmem)
   989                          return -1;
   990  
   991                  paddr = virt_to_phys(vmem);

Pretty straight forward that the static checker is right but I can't
give you any hints how to fix it.

   992          }
   993  
   994          return paddr;
   995  }

regards,
dan carpenter
