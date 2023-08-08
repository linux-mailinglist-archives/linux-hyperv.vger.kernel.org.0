Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591DD773E9F
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Aug 2023 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjHHQdW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Aug 2023 12:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjHHQc1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Aug 2023 12:32:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0233101E
        for <linux-hyperv@vger.kernel.org>; Tue,  8 Aug 2023 08:51:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so7536441a12.2
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Aug 2023 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509906; x=1692114706;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKTsRLuKf3QyWXMcuIhzP2d0GmUQqCPbLjMRBUpnJIA=;
        b=H/5JGDBk+CeVnrBV2o5uJ3G38CgdILFJIZ+hBONRPE8IhybxpTWsEGdkQIIJ8MTtQR
         7DPCJhSObTaoojAZXxoH8Fm2qVRPnfQLurHR4cMDWjHIwKLZrh2CUaxdvyQ7JHRHgQzi
         7CBJV26MAvWOFicJJH+hTRzyQncaLFUi6mt6puDO9Jc9F4k25lgRwbnQqTivkBMLi0eq
         WGtOHEIC7ucAUbBYFrquKIJpcRa07Y0qw1A3sdd1Qfp9PRurnRPmlsO7yLwxydvAxnDl
         q/rR/hfGin0p2XLiNlgu8Vncwbgn6qtsrAXYCEhykv2NH6WggpQ64RcJAAeI7DXce+cL
         Ks1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509906; x=1692114706;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKTsRLuKf3QyWXMcuIhzP2d0GmUQqCPbLjMRBUpnJIA=;
        b=Eqkjao0U6yfHIr11gGKiXR4Fet2hhALq2lWcXACRgt3UTUTqe+GpmB4A8RZ9pxb9g+
         bzbQ8Cj2IARZY75JMc73AE0GP/8GPjRJpdFmMLG0GeuVk7l2jsQUtchdvxr1NvCUe1Ng
         XIu/MiRIz0O/1cpLe1xGTShxwMAt8B1mT0/6jUq4JWDzSNaUEWphGTrkdriSPtPL3ZNe
         6EVlg3QZi6bnbsWKvGZWCWRmrU4TV7TpZLX/067rkdQJr211bjKX/ETrAMdNvpOcha4K
         wm6gyaDJU/Tp0349ox+J/OQ35z4OxFMipum1oYgCEY3aFlwQ37Zrf65QxzZA4lK/JEUk
         SowQ==
X-Gm-Message-State: AOJu0YxmhlhtijlsqU2aaIufgk1p/+KeNIkVZAFJSQKD7YzUFnSjamW/
        qkGtg/1Uzd+2UbVGh9tGMdiEmCK36qykEB/q4Ok=
X-Google-Smtp-Source: AGHT+IHXCSD2ggLs7VrDJoydN4hARg8w0jISZTRRZqbXk/wNXXFkmPJke33ZqfqUwtq7V+GQpKeKow==
X-Received: by 2002:a19:5f5b:0:b0:4fe:4f8:8e75 with SMTP id a27-20020a195f5b000000b004fe04f88e75mr6964205lfj.68.1691475049547;
        Mon, 07 Aug 2023 23:10:49 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709061c5a00b0099bc5e5742asm6174398ejg.70.2023.08.07.23.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 23:10:48 -0700 (PDT)
Date:   Tue, 8 Aug 2023 09:10:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     haiyangz@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Subject: [bug report] net: mana: Add page pool for RX buffers
Message-ID: <72639c0d-9cf5-468e-ad6a-e36c25d63b02@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Haiyang Zhang,

The patch b1d13f7a3b53: "net: mana: Add page pool for RX buffers"
from Aug 4, 2023 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/ethernet/microsoft/mana/mana_en.c:1651 mana_process_rx_cqe()
	error: uninitialized symbol 'old_fp'.

drivers/net/ethernet/microsoft/mana/mana_en.c
    1592 static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
    1593                                 struct gdma_comp *cqe)
    1594 {
    1595         struct mana_rxcomp_oob *oob = (struct mana_rxcomp_oob *)cqe->cqe_data;
    1596         struct gdma_context *gc = rxq->gdma_rq->gdma_dev->gdma_context;
    1597         struct net_device *ndev = rxq->ndev;
    1598         struct mana_recv_buf_oob *rxbuf_oob;
    1599         struct mana_port_context *apc;
    1600         struct device *dev = gc->dev;
    1601         void *old_buf = NULL;
    1602         u32 curr, pktlen;
    1603         bool old_fp;
    1604 
    1605         apc = netdev_priv(ndev);
    1606 
    1607         switch (oob->cqe_hdr.cqe_type) {
    1608         case CQE_RX_OKAY:
    1609                 break;
    1610 
    1611         case CQE_RX_TRUNCATED:
    1612                 ++ndev->stats.rx_dropped;
    1613                 rxbuf_oob = &rxq->rx_oobs[rxq->buf_index];
    1614                 netdev_warn_once(ndev, "Dropped a truncated packet\n");
    1615                 goto drop;
    1616 
    1617         case CQE_RX_COALESCED_4:
    1618                 netdev_err(ndev, "RX coalescing is unsupported\n");
    1619                 apc->eth_stats.rx_coalesced_err++;
    1620                 return;
    1621 
    1622         case CQE_RX_OBJECT_FENCE:
    1623                 complete(&rxq->fence_event);
    1624                 return;
    1625 
    1626         default:
    1627                 netdev_err(ndev, "Unknown RX CQE type = %d\n",
    1628                            oob->cqe_hdr.cqe_type);
    1629                 apc->eth_stats.rx_cqe_unknown_type++;
    1630                 return;
    1631         }
    1632 
    1633         pktlen = oob->ppi[0].pkt_len;
    1634 
    1635         if (pktlen == 0) {
    1636                 /* data packets should never have packetlength of zero */
    1637                 netdev_err(ndev, "RX pkt len=0, rq=%u, cq=%u, rxobj=0x%llx\n",
    1638                            rxq->gdma_id, cq->gdma_id, rxq->rxobj);
    1639                 return;
    1640         }
    1641 
    1642         curr = rxq->buf_index;
    1643         rxbuf_oob = &rxq->rx_oobs[curr];
    1644         WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
    1645 
    1646         mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);

If mana_get_rxfrag() fails then mana_refill_rx_oob() doesn't set *old_fp.


    1647 
    1648         /* Unsuccessful refill will have old_buf == NULL.
    1649          * In this case, mana_rx_skb() will drop the packet.
    1650          */
--> 1651         mana_rx_skb(old_buf, old_fp, oob, rxq);
    1652 
    1653 drop:
    1654         mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
    1655 
    1656         mana_post_pkt_rxq(rxq);
    1657 }

regards,
dan carpenter
