Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF88264360
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Sep 2020 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIJKLX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Sep 2020 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIJKLH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Sep 2020 06:11:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F4C061573;
        Thu, 10 Sep 2020 03:11:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g128so6395806iof.11;
        Thu, 10 Sep 2020 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oq85Kv8Q2AnOzhchKRfF2cZCLjCk+7ncSapWENTEmk0=;
        b=NpOvnUxQq6zIh7M0z4jf/7u5uRWZt/oSXLnIqUkyv7UHc7QlSUjFlxN8w01avNNj5R
         GIm+2WkUVIuiSioAVODbjW358fbxikoLVuYG4exvQcak7FjX/IiYRTX2PzzNjc1PoJFu
         DWSfs6JHmRc2Fx5/G78235gadr2zBFYDEN1v+xGV8GrXaDQz8ZvlkBF/g2ayWbki0KPT
         UdJIeElMyVOnUo3VuKz0UrZvS7qPqc2RKC3bpuoCD/bYQR81k8PL1p1o8VuZrhgjA0mY
         MtYtT/CLOcJb6YQ7fiCkCbegRa2yQUPI4mkjZ52U8tPadGGyP0T2+W8VV4KaZiJBn7fI
         xh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oq85Kv8Q2AnOzhchKRfF2cZCLjCk+7ncSapWENTEmk0=;
        b=G5WYSXN6rB2ZacUlMyS1z47nGT4XjoX03+GiLeD7L5r8L3TCCTquinRo6l/jXpe1h9
         Lr+UhGWGuDD6//WLWghBXYV+lzYKVbnBXhq0JLqy5QEEnlMPF288ylh9qXn9qvwVhvbo
         4lSRS72gAZIHVYWTa0AMfCmzNrP6Z17n6mwBUIBzSGd/FoYaZVsDE2DJYjF7Z0HIIkut
         aWOr6FkZAxadbCY+lRJpMGjiMSUUkX2SmSE1+e/DyRenX9iNTfchhGm7+6+sICHpULss
         W2YRNCdnJc4qrAs0dvgkOubIY/JdxznnbGIyv12XHMlPybJwe9qbmaPK7A/KMiTC4V+n
         ZtGQ==
X-Gm-Message-State: AOAM532IsAN0g/XPpV5ECvadjzry1KfimY7+Yh3ialZKN5pQe8zqKqE/
        WH30taMXEpKI9plCiOj0RbR4jfDydyYU95fc/3k=
X-Google-Smtp-Source: ABdhPJzKGRYgqpr+9cz3Q74NoY3jG8toy/e9Rt6AOpX9QHNPs+I2y7L9ikBZUu1GNvFqq1njb4EKG9NdktrkvXJEm78=
X-Received: by 2002:a6b:fb0c:: with SMTP id h12mr6197002iog.98.1599732666180;
 Thu, 10 Sep 2020 03:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200910091340.8654-1-david@redhat.com> <20200910091340.8654-6-david@redhat.com>
In-Reply-To: <20200910091340.8654-6-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 10 Sep 2020 12:10:54 +0200
Message-ID: <CAM9Jb+jQP+n-bCxYHTwOFQm-+D3VZj+MhqmUMnu9xVoxs2a4VA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] virtio-mem: try to merge system ram resources
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
