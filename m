Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF570F7912
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2019 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKQrX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Nov 2019 11:47:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41189 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKQrX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Nov 2019 11:47:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so11031481pfq.8
        for <linux-hyperv@vger.kernel.org>; Mon, 11 Nov 2019 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1uln3PQWpJHVN0cvSdX7VnkuLpysZdK64D1CGthDMQQ=;
        b=ZGldm3S4bKZDsolIkr062FeCWNvgqBDCbXBCZQSlgjXHxjrJOCNka+55vftk5tfbjO
         xM+8nieUBc2AaHtdsnK3zOkygz7oCeH3iSjCF9E/DpsUwm0ogx6DuoGw4RGJIIjds2xf
         9QVw5/y5wXbeGEku9KqrasNNLbW1Qyp1qCPhJFXZov/EYKd0Mdxb2X5C3QjYJ208kiTX
         Wkw6tBRfnSUeC1R+4MgsXVLIXOE9875v0yvZ1QQsQbBYTzmu+DXPa8l2DiT2+UHlkYlu
         QJJcdoqKQO0+K+L/5aRb7X+ffsioxLikRuP7FuWx6HD1CpQs+uDJ9EaAgwKeCl2k9QSN
         FsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1uln3PQWpJHVN0cvSdX7VnkuLpysZdK64D1CGthDMQQ=;
        b=B2I4sPhjdbIvOhruHYPEZn419ix3xlEIUz52OspoQjVBx8iSA27OEibEJUcEpSHIOS
         /QW2nXlQFtwNrIyu2g8DXWurtVYtsR5yLCJiE0AMBVQxTHPA7vwemWJ4ruAaVvrOzM//
         EHYMyCBheQbv/DKZXAinpV+wbJBTCbHM3sjOQguQGsFVkeYoGPT/9VXbWvaIpq1xNRaE
         +hiv9fqc8j5E3wYbIjQnG0/ajp8Hn//ILOpfkJOdtoMnNtZgfKDQ3RJsTJscg3ZvtN+0
         wth1qstMqRDiBzyEQkYuv9Mwima+jB4pQ3NLMwOa9VDeCY/Gys5ZcwZYdEtDNxuVrDIN
         ru3A==
X-Gm-Message-State: APjAAAVYDXg3tBRw8Y38MHdbtglPPhRhpCRGGWsR4/MnMUc0fy+D6T8Q
        N+NP9txKn9gt2obuXgesEgmSWA==
X-Google-Smtp-Source: APXvYqxIqglx9JQpZhfV6sn5yZId682STyaqTWhX69LzBX/PclD2m0DM/D8mPbJZgsMlMwbmAnwP5g==
X-Received: by 2002:a62:1bd0:: with SMTP id b199mr31175476pfb.44.1573490842323;
        Mon, 11 Nov 2019 08:47:22 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 186sm4038077pfe.141.2019.11.11.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 08:47:21 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:47:12 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     <lantianyu1986@gmail.com>, <alex.williamson@redhat.com>,
        <cohuck@redhat.com>, "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <robh@kernel.org>, <Jonathan.Cameron@huawei.com>,
        <paulmck@linux.ibm.com>, "Michael Kelley" <mikelley@microsoft.com>,
        "Tianyu Lan" <Tianyu.Lan@microsoft.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, "vkuznets" <vkuznets@redhat.com>
Subject: Re: [PATCH] VFIO/VMBUS: Add VFIO VMBUS driver support
Message-ID: <20191111084712.37ba7d5a@hermes.lan>
In-Reply-To: <20191111094920.GA135867@kroah.com>
References: <20191111084507.9286-1-Tianyu.Lan@microsoft.com>
        <20191111094920.GA135867@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 11 Nov 2019 01:49:20 -0800
"Greg KH" <gregkh@linuxfoundation.org> wrote:

> > +	ret = sysfs_create_bin_file(&channel->kobj,  
> &ring_buffer_bin_attr);
> > +	if (ret)
> > +		dev_notice(&dev->device,
> > +			   "sysfs create ring bin file failed; %d\n",  
> ret);
> > +  
> 
> Again, don't create sysfs files on your own, the bus code should be
> doing this for you automatically and in a way that is race-free.
> 
> thanks,
> 
> greg k-h

The sysfs file is only created if the VFIO/UIO driveris used.
