Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F881B46F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDVOPI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 10:15:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:58962 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgDVOPI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 10:15:08 -0400
IronPort-SDR: BuwFXgvj3iCrwkr506mBdpkKe6eYKdGdooMIvDAPVTjW6XwWFYsULP2g8C4y2EccSfF2F03RYw
 x6obg2qNVt7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:15:06 -0700
IronPort-SDR: Y5+hzBo/ISyauFtozzvypS98EKgn810zU9fXhomokYS4Iz/PKJJpkUVvGeFR6pBf6Jem0s/Jju
 eA8OA0N/3Zuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="334630789"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 22 Apr 2020 07:15:04 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jRG9b-002SQ6-Hm; Wed, 22 Apr 2020 17:15:07 +0300
Date:   Wed, 22 Apr 2020 17:15:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v1] hyper-v: Remove internal types from UAPI header
Message-ID: <20200422141507.GI185537@smile.fi.intel.com>
References: <20200422131818.23088-1-andriy.shevchenko@linux.intel.com>
 <20200422134127.zgsympiwgvp7hdam@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422134127.zgsympiwgvp7hdam@debian>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 02:41:27PM +0100, Wei Liu wrote:
> On Wed, Apr 22, 2020 at 04:18:18PM +0300, Andy Shevchenko wrote:
> > The uuid_le mistakenly comes to be an UAPI type. Since it's luckily not used by
> > Hyper-V APIs, we may replace with POD types, i.e. __u8 array.
> > 
> > Note, previously shared uuid_be had been removed from UAPI few releases ago.
> > This is a continuation of that process towards removing uuid_le one.
> > 
> > Note, there is no ABI change!
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Can you clarify why guid_t is not used instead?

It's internal type to the kernel. The libuuid or so should provide a compatible
type(s) for user space.

> Is the plan to remove it
> from UAPI as well?

Yes.

> Wei.
> 
> > ---
> >  include/uapi/linux/hyperv.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
> > index 991b2b7ada7a3..8f24404ad04f1 100644
> > --- a/include/uapi/linux/hyperv.h
> > +++ b/include/uapi/linux/hyperv.h
> > @@ -119,8 +119,8 @@ enum hv_fcopy_op {
> >  
> >  struct hv_fcopy_hdr {
> >  	__u32 operation;
> > -	uuid_le service_id0; /* currently unused */
> > -	uuid_le service_id1; /* currently unused */
> > +	__u8 service_id0[16]; /* currently unused */
> > +	__u8 service_id1[16]; /* currently unused */
> >  } __attribute__((packed));
> >  
> >  #define OVER_WRITE	0x1
> > -- 
> > 2.26.1
> > 

-- 
With Best Regards,
Andy Shevchenko


